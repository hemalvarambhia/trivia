import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary


class TestRollingTheDieFromInsidePenaltyBox(unittest.TestCase):

    def test_rolling_an_odd_number_allows_current_player_to_leave_penalty_box(self):
        with GameWithCommentary() as game:
            game.between(players=['Player 1', 'Irrelevant Player'])

            # Player 1 turn.
            self.current_player_rolls_and_answered_incorrectly(game)
            # Now it is Irrelevant Player's turn.

            self.current_player_rolls_and_answers_their_question(game)
            # Now it is Player 1's turn.

            # Current Player rolls an odd number.
            game.roll(1)

            self.assertEqual('Player 1 is getting out of the penalty box', game.commentary()[-4])
            self.assertEqual(True, game.is_getting_out_of_penalty_box)

    def test_current_player_moves_a_number_of_steps_forward_on_rolling_an_odd_number(self):
        with GameWithCommentary() as game:
            game.between(players=['Player 1', 'Irrelevant Player'])

            # Player 1's turn
            self.current_player_rolls_and_answered_incorrectly(game)

            self.current_player_rolls_and_answers_their_question(game)

            # Player 1 rolls an odd number.
            game.roll(1)

            self.assertEqual("Player 1's new location is 6", game.commentary()[-3])

    def test_current_player_is_asked_question_for_the_given_category_on_rolling_an_odd_number(self):
        with GameWithCommentary() as game:
            game.between(players=['Player 1', 'Irrelevant Player'])

            # Player 1's turn
            self.current_player_rolls_and_answered_incorrectly(game)

            self.current_player_rolls_and_answers_their_question(game)

            game.roll(5)

            self.assertEqual("The category is Sports", game.commentary()[-2])
            self.assertEqual("Sports Question 0", game.commentary()[-1])

    def test_current_player_cannot_leave_penalty_box_on_rolling_an_even_number(self):
        with GameWithCommentary() as game:
            game.between(players=['Player 1', 'Irrelevant Player'])
            # Player 1's turn.
            self.current_player_rolls_and_answered_incorrectly(game)

            self.current_player_rolls_and_answers_their_question(game)

            # Player 1 rolls an even number, meaning they cannot leave the penalty box
            game.roll(4)

            self.assertEqual("Player 1 is not getting out of the penalty box", game.commentary()[-1])
            self.assertEqual(False, game.is_getting_out_of_penalty_box)

    @unittest.skip('Test list')
    def test_current_player_can_enter_penalty_box_then_leave_it_and_reenter_later(self):
        pass

    def current_player_rolls_and_answered_incorrectly(self, game):
        game.roll(5)
        game.wrong_answer()

    def current_player_rolls_and_answers_their_question(self, game):
        irrelevant_die_face = 1
        game.roll(irrelevant_die_face)
        game.was_correctly_answered()


if __name__ == '__main__':
    unittest.main()
