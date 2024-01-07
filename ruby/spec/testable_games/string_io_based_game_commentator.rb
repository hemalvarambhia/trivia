require 'game_event_listener'
module UglyTrivia
  class StringIOBasedGameCommentator
    include GameEventListener

    def initialize
      @commentary = StringIO.new
    end

    def commentary
      @commentary.string.split("\n")
    end

    def display(message)
      puts message
    end

    def puts(message)
      @commentary.puts(message)
    end
  end
end
