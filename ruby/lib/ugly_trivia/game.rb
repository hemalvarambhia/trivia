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
                   :moved,
                   :answer_was_correct,
                   :question_answered_incorrectly,
                   :commentate_gold_coins_won_by,
                   :gold_coin_awarded_to,
                   :sent_to_penalty_box,
                   :display
    def self.with(players)
      new.tap do |trivia|
        players.each { |player| trivia.add(player) }
      end
    end

    def initialize
      @trivia_players = []
      @in_penalty_box = Array.new(6, nil)
      @current_player = 0
      @is_getting_out_of_penalty_box = false

      @deck_of_questions = UglyTrivia::DeckOfQuestions.new
      @commentary = StdOutBasedGameCommentator.new
    end

    # SMELL: this method has no clients.
    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      trivial_player = Player.new(name: player_name)
      @trivia_players << trivial_player
      @in_penalty_box[how_many_players] = trivial_player.in_penalty_box?

      display "#{trivial_player.name} was added"
      display "They are player number #{@trivia_players.count}"
    end

    def how_many_players
      @trivia_players.count
    end

    def roll(roll)
      trivia_player = current_trivia_player
      display "#{trivia_player.name} is the current player"
      display "They have rolled a #{roll}"
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

      trivia_player.advance(roll)
      moved(trivia_player)
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
      award_gold_coin_and_display_message(current_trivia_player)
      no_winner = !current_trivia_player.won?
      next_players_turn
      return no_winner
    end

    def wrong_answer
      question_answered_incorrectly
      place_in_penalty_box_and_display_message(@current_player)

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

    private

    def current_trivia_player
      @trivia_players[@current_player]
    end

    def next_players_turn
      @current_player += 1
      @current_player = 0 if @current_player == @trivia_players.count
    end

    def place_in_penalty_box_and_display_message(player)
      place_in_penalty_box(player)
      trivia_player = @trivia_players[player]
      sent_to_penalty_box(trivia_player)
    end

    def place_in_penalty_box(player)
      @trivia_players[player].place_in_penalty_box
      @in_penalty_box[player] = @trivia_players[player].in_penalty_box?
    end

    def award_gold_coin_and_display_message(trivia_player)
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
