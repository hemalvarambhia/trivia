require 'game_event_listener'
module UglyTrivia
  class StdOutBasedGameCommentator
    include GameEventListener

    def player_added(trivial_player, number)
      display "#{trivial_player.name} was added"
      display "They are player number #{number}"
    end

    def die_rolled(face_landed_on, trivia_player)
      display "#{trivia_player.name} is the current player"
      display "They have rolled a #{face_landed_on}"
    end

    def moved(trivia_player)
      display "#{trivia_player.name}'s new location is #{trivia_player.location}"
    end

    def answer_was_correct
      display "Answer was correct!!!!"
    end

    def question_answered_incorrectly
      display 'Question was incorrectly answered'
    end

    def sent_to_penalty_box(trivia_player)
      display "#{trivia_player.name} was sent to the penalty box"
    end

    def gold_coin_awarded_to(trivia_player)
      display "#{trivia_player.name} now has #{trivia_player.gold_coins} Gold Coins."
    end

    def display(message)
      puts message
    end
  end
end
