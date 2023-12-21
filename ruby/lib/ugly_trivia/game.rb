require_relative './deck_of_questions'
require_relative './player'
module UglyTrivia
  class Game
    attr_reader :current_player, :in_penalty_box, :is_getting_out_of_penalty_box

    def self.with(players)
      new.tap do |trivia|
        players.each { |player| trivia.add(player) }
      end
    end

    def  initialize
      @players = []
      @trivia_players = []
      @in_penalty_box = Array.new(6, nil)
      @current_player = 0
      @is_getting_out_of_penalty_box = false

      @deck_of_questions = UglyTrivia::DeckOfQuestions.new
    end

    # SMELL: this method has no clients.
    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push player_name
      @trivia_players << Player.new(name: player_name)
      @in_penalty_box[how_many_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"
    end

    def how_many_players
      @players.length
    end

    def roll(roll)
      puts "#{name_of(@current_player)} is the current player"
      display "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll.odd?
          @is_getting_out_of_penalty_box = true
          puts "#{name_of(@current_player)} is getting out of the penalty box"
        else
          puts "#{name_of(@current_player)} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          return
        end
      end

      advance(@current_player, roll)
      place = location_of(@current_player)
      display "#{name_of(@current_player)}'s new location is #{place}"
      display "The category is #{current_category(place)}"
      ask_question_and_display_message(current_category(place))
    end

    def was_correctly_answered
      if @in_penalty_box[@current_player]
        unless @is_getting_out_of_penalty_box
          next_players_turn
          return true
        end
      end

      display "Answer was correct!!!!"
      award_gold_coin_and_display_message(@current_player)
      no_winner = !won?(@current_player)
      next_players_turn
      return no_winner
    end

    def wrong_answer
      display 'Question was incorrectly answered'
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

    def ask_question_and_display_message(category)
      question = @deck_of_questions.pick_question_for category

      display question
    end

    def name_of(player)
      @trivia_players[player].name
    end

    def location_of(player)
      @trivia_players[player].location
    end

    def place_in_penalty_box_and_display_message(player)
      @in_penalty_box[player] = true
      display "#{name_of(player)} was sent to the penalty box"
    end

    def advance(player, number_of_places)
      @trivia_players[player].advance(number_of_places)
    end

    def award_gold_coin_and_display_message(player)
      @trivia_players[player].award_coin
      number_of_gold_coins = @trivia_players[player].gold_coins
      display "#{name_of(player)} now has #{number_of_gold_coins} Gold Coins."
    end

    def won?(player)
      @trivia_players[player].won?
    end

    def next_players_turn
      @current_player += 1
      @current_player = 0 if @current_player == @players.length
    end

    def display(message)
      puts message
    end
  end
end
