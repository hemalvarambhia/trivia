require 'game_event_listener'
module UglyTrivia
  class StdOutBasedGameCommentator
    include GameEventListener

    def display(message)
      puts message
    end
  end
end
