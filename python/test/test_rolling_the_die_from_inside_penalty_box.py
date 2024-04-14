import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary


class TestRollingTheDieFromInsidePenaltyBox(unittest.TestCase):

    def test_rolling_an_odd_number_allows_current_player_to_leave_penalty_box(self):
        with GameWithCommentary() as game:
            game.add('Current Player')
            game.add('Irrelevant Player')

            # Current Player's turn rolls the die and answers incorrectly, meaning they
            # are placed inside the penalty box.
            game.roll(5)
            game.wrong_answer()
            # Now it is Irrelevant Player's turn.

            # Irrelevant Player rolls the die and answers correctly.
            game.roll(1)
            game.was_correctly_answered()
            # Now it is Current Player's turn.

            # Current Player rolls an odd number.
            game.roll(1)

            self.assertEqual('Current Player is getting out of the penalty box', game.commentary()[-4])

    def test_current_player_moves_a_number_of_steps_forward_when_they_roll_an_odd_number(self):
       with GameWithCommentary() as game:
           game.add('Current Player')
           game.add('Irrelevant Player')

           # Current Player's turn rolls the die and answers incorrectly, meaning they
           # are placed inside the penalty box.
           game.roll(5)
           game.wrong_answer()

           # Irrelevant Player rolls the die and answers correctly.
           game.roll(1)
           game.was_correctly_answered()

           # Current Player rolls an odd number.
           game.roll(1)

           self.assertEqual("Current Player's new location is 6", game.commentary()[-3])


if __name__ == '__main__':
    unittest.main()
