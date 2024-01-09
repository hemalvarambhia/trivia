require 'game_event_listener'
module UglyTrivia
  class StdOutBasedGameCommentator
    include GameEventListener

    def initialize
      @commentary = $stdout
    end

    def display(message)
      @commentary.puts message
    end
  end
end
