module UglyTrivia
  class Player
    attr_reader :name, :gold_coins

    def initialize(name:)
      @name = name
      @gold_coins = 0
      @place = 0
    end

    def advance(number_of_places)
      @place = (@place + number_of_places) % 12
    end

    def location
      @place
    end

    def award_coin
      @gold_coins += 1
    end

    def won?
      @gold_coins == 6
    end
  end
end
