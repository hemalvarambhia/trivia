module UglyTrivia
  class GameBoard
    def initialize
      @categories_per_place = {
        0 => 'Pop', 4 => 'Pop', 8 => 'Pop',
        1 => 'Science', 5 => 'Science', 9 => 'Science',
        2 => 'Sports', 6 => 'Sports', 10 => 'Sports',
        3 => 'Rock', 7 => 'Rock', 11 => 'Rock'
      }
    end

    def current_category(place)
      @categories_per_place[place]
    end
  end
end
