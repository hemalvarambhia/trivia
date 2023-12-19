module UglyTrivia
  class Player
    attr_reader :name, :gold_coins

    def initialize(name:)
      @name = name
      @gold_coins = 0
    end

    def award_coin
      @gold_coins += 1
    end
  end
end
