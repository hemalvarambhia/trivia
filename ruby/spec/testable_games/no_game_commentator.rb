module UglyTrivia
  class NoGameCommentator
    def commentary
      []
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

    def commentate_gold_coins_won_by(trivia_player)
      display "#{trivia_player.name} now has #{trivia_player.gold_coins} Gold Coins."
    end

    def display(message)
      puts message
    end

    def puts(message)
      # no op
    end
  end
end
