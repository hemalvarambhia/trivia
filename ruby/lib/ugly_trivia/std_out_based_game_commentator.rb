module UglyTrivia
  class StdOutBasedGameCommentator
    def commentate_on_players_location(trivia_player)
      display "#{trivia_player.name}'s new location is #{trivia_player.location}"
    end
    alias_method :moved, :commentate_on_players_location

    def commentate_answer_was_correct
      display "Answer was correct!!!!"
    end

    def commentate_question_incorrectly_answered
      display 'Question was incorrectly answered'
    end

    def commentate_sent_to_penalty_box(trivia_player)
      display "#{trivia_player.name} was sent to the penalty box"
    end

    def commentate_gold_coins_won_by(trivia_player)
      display "#{trivia_player.name} now has #{trivia_player.gold_coins} Gold Coins."
    end

    def display(message)
      puts message
    end
  end
end
