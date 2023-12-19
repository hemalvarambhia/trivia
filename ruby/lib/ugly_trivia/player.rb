module UglyTrivia
  class Player
    attr_reader :name

    def initialize(name:)
      @name = name
      @gold_coins = 0
    end

    def award_coin
      @gold_coins += 1
    end
  end
end
