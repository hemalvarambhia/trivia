require 'forwardable'
$LOAD_PATH.unshift(File.expand_path('ugly_trivia', 'lib'))
require 'std_out_based_game_commentator'
require 'deck_of_questions'
require 'player'
module UglyTrivia
  class Game
    extend Forwardable

    attr_reader :current_player, :in_penalty_box, :is_getting_out_of_penalty_box
    def_delegators :@commentary,
                   :die_rolled,
                   :moved,
                   :answer_was_correct,
                   :question_answered_incorrectly,
                   :gold_coin_awarded_to,
                   :sent_to_penalty_box,
                   :display
    def self.with(players)
      new.tap do |trivia|
        players.each { |player| trivia.add(player) }
      end
    end

    def initialize(commentary: StdOutBasedGameCommentator.new)
      @trivia_players = []
      @current_player = 0
      @is_getting_out_of_penalty_box = false

      @deck_of_questions = UglyTrivia::DeckOfQuestions.new
      @commentary = commentary
    end

    # SMELL: this method has no clients.
    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      trivial_player = Player.new(name: player_name)
      @trivia_players << trivial_player

      player_added(trivial_player, @trivia_players.count)
    end

    def how_many_players
      @trivia_players.count
    end

    def roll(roll)
      trivia_player = current_trivia_player
      die_rolled(roll, trivia_player)
      if trivia_player.in_penalty_box?
        if roll.odd?
          @is_getting_out_of_penalty_box = true
          puts "#{trivia_player.name} is getting out of the penalty box"
        else
          puts "#{trivia_player.name} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          return
        end
      end

      move(trivia_player, roll)
      ask_question_to(trivia_player)
    end

    def was_correctly_answered
      if current_trivia_player.in_penalty_box?
        unless @is_getting_out_of_penalty_box
          next_players_turn
          return true
        end
      end

      answer_was_correct
      award_gold_coin_to(current_trivia_player)
      no_winner = !current_trivia_player.won?
      next_players_turn
      return no_winner
    end

    def wrong_answer
      question_answered_incorrectly
      send_to_penalty_box(@current_player)

      next_players_turn
      return true
    end

    def current_category(place)
      @deck_of_questions.current_category(place)
    end

    def purses
      @trivia_players.map(&:gold_coins)
    end

    def places
      @trivia_players.map(&:location)
    end

    def in_penalty_box
      @trivia_players.map(&:in_penalty_box?)
    end

    private

    def player_added(trivial_player, number = @trivia_players.count)
      display "#{trivial_player.name} was added"
      display "They are player number #{number}"
    end

    def current_trivia_player
      @trivia_players[@current_player]
    end

    def next_players_turn
      @current_player += 1
      @current_player = 0 if @current_player == @trivia_players.count
    end

    def move(trivia_player, number_of_places)
      trivia_player.move(number_of_places)
      moved(trivia_player)
    end

    def send_to_penalty_box(player)
      trivia_player = @trivia_players[player]
      trivia_player.place_in_penalty_box
      sent_to_penalty_box(trivia_player)
    end

    def award_gold_coin_to(trivia_player)
      trivia_player.award_coin
      gold_coin_awarded_to(trivia_player)
    end

    def ask_question_to(trivia_player)
      category = current_category(trivia_player.location)
      question = @deck_of_questions.pick_question_for category

      display "The category is #{category}"
      display question
    end
  end
end
