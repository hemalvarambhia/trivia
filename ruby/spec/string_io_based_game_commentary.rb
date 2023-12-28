module UglyTrivia
  class StringIOBasedGameCommentary
    def initialize
      @commentary = StringIO.new
    end

    def commentary
      @commentary.string.split("\n")
    end

    def puts(message)
      @commentary.puts(message)
    end
  end
end
