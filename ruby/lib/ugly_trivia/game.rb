require_relative './deck_of_questions'
module UglyTrivia
  class Game
    attr_reader :places, :purses, :current_player, :in_penalty_box, :is_getting_out_of_penalty_box

    def self.with(players)
      new.tap do |trivia|
        players.each { |player| trivia.add(player) }
      end
    end

    def  initialize
      @players = []
      @places = Array.new(6, 0)
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      @deck_of_questions = DeckOfQuestions.new
    end

    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push player_name
      @places[how_many_players] = 0
      @purses[how_many_players] = 0
      @in_penalty_box[how_many_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"
    end

    def how_many_players
      @players.length
    end

    def roll(roll)
      puts "#{@players[@current_player]} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll.odd?
          @is_getting_out_of_penalty_box = true
          puts "#{@players[@current_player]} is getting out of the penalty box"
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          return
        end
      end

      advance(@current_player, roll)
      place = @places[@current_player]
      puts "#{@players[@current_player]}'s new location is #{place}"
      puts "The category is #{Game.current_category(place)}"
      ask_question(Game.current_category(place))
    end

    def science_questions
      @deck_of_questions.questions_for 'Science'
    end

    def pop_questions
      @deck_of_questions.questions_for 'Pop'
    end

    def rock_questions
      @deck_of_questions.questions_for 'Rock'
    end

    def sports_questions
      @deck_of_questions.questions_for 'Sports'
    end

    def was_correctly_answered
      if @in_penalty_box[@current_player]
        unless @is_getting_out_of_penalty_box
          next_players_turn
          return true
        end
      end

      puts "Answer was correct!!!!"
      award_gold_coin_to(@current_player)
      no_winner = has_not_won?(@current_player)
      next_players_turn
      return no_winner
    end

    def wrong_answer
      puts 'Question was incorrectly answered'
      place_in_penalty_box(@current_player)

      next_players_turn
      return true
    end

    def self.current_category(place)
      DeckOfQuestions.new.categories[place]
    end

    private

    def ask_question(category)
      question = pick_question_for(category)

      puts question
    end

    def pick_question_for(category)
      @deck_of_questions.pick_question_for category
    end

    def place_in_penalty_box(player)
      puts "#{@players[player]} was sent to the penalty box"
      @in_penalty_box[player] = true
    end

    def advance(player, number_of_places)
      @places[player] = (@places[player] + number_of_places) % 12
    end

    def award_gold_coin_to(player)
      @purses[player] += 1
      puts "#{@players[player]} now has #{@purses[player]} Gold Coins."
    end

    def has_not_won?(player)
      !(@purses[player] == 6)
    end

    def next_players_turn
      @current_player += 1
      @current_player = 0 if @current_player == @players.length
    end
  end
end
