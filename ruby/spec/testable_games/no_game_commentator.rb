require 'game_event_listener'
module UglyTrivia
  class NoGameCommentator
    include GameEventListener
    def commentary
      []
    end
    def display(message)
      # no op
    end
  end
end
