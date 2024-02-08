require 'game_board'
module UglyTrivia
  class DeckOfQuestions

    def initialize(questions_by_category = {
          'Pop' => Array.new(50) { |i| "Pop Question #{i}" },
          'Science' => Array.new(50) { |i| "Science Question #{i}" },
          'Sports' => Array.new(50) { |i| "Sports Question #{i}" },
          'Rock' => Array.new(50) { |i| "Rock Question #{i}" }
        })
      @game_board = GameBoard.new

      @questions = questions_by_category
    end

    def pick_question_for(category)
      questions_for(category).shift
    end

    def questions_for(category)
      @questions[category]
    end

    def current_category(place)
      @game_board.current_category(place)
    end
  end
end
