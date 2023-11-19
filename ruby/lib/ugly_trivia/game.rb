module UglyTrivia
  class Game
    attr_reader :places, :purses, :current_player, :in_penalty_box, :is_getting_out_of_penalty_box
    attr_reader :science_questions, :pop_questions, :sports_questions, :rock_questions

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

      prepare_questions
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

      true
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
          @places[@current_player] = @places[@current_player] + roll
          @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

          puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
          puts "The category is #{current_category}"
          ask_question
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          end

      else

        advance_current_player(roll)

        puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
        puts "The category is #{current_category}"
        ask_question
      end
    end

  private

    def ask_question
      question = pick_question_for(current_category)

      puts question
    end

    def pick_question_for(category)
      case category
      when 'Pop'
        @pop_questions.shift
      when 'Science'
        @science_questions.shift
      when 'Sports'
        @sports_questions.shift
      when 'Rock'
        @rock_questions.shift
      end
    end

    def current_category
      {
        0 => 'Pop',
        4 => 'Pop',
        8 => 'Pop',
        1 => 'Science',
        5 => 'Science',
        9 => 'Science',
        2 => 'Sports',
        6 => 'Sports',
        10 => 'Sports',
        3 => 'Rock',
        7 => 'Rock',
        11 => 'Rock'
      }[@places[@current_player]]
    end

    public

    def was_correctly_answered
      if @in_penalty_box[@current_player]
        if @is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          award_gold_coin

          winner = did_player_win()
          next_players_turn

          winner
        else
          next_players_turn
          true
        end
      else

        puts "Answer was corrent!!!!"
        award_gold_coin

        winner = did_player_win
        next_players_turn

        return winner
      end
    end

    def wrong_answer
  		puts 'Question was incorrectly answered'
  		puts "#{@players[@current_player]} was sent to the penalty box"
  		@in_penalty_box[@current_player] = true

      next_players_turn
  		return true
    end

  private

    def advance_current_player(number_of_places)
      @places[@current_player] = @places[@current_player] + number_of_places
      @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11
    end

    def prepare_questions
      @pop_questions = Array.new(50) { |i| "Pop Question #{i}" }
      @science_questions = Array.new(50) { |i| "Science Question #{i}" }
      @sports_questions = Array.new(50) { |i| "Sports Question #{i}" }
      @rock_questions = Array.new(50) { |i| "Rock Question #{i}" }
    end

    def did_player_win
      !(@purses[@current_player] == 6)
    end

    def next_players_turn
      @current_player += 1
      @current_player = 0 if @current_player == @players.length
    end

    def award_gold_coin
      @purses[@current_player] += 1
      puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."
    end
  end
end
