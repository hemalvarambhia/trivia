import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary
from test.play_trivia_test import PlayTriviaTest


class TestRollingTheDieFromInsidePenaltyBox(PlayTriviaTest):

    def test_rolling_an_odd_number_allows_current_player_to_leave_penalty_box(self):
        with GameWithCommentary() as game:
            self.between(game, 'Current Player', 'Irrelevant Player')

            # Current Player's turn rolls the die and answers incorrectly, meaning they
            # are placed inside the penalty box.
            self.current_player_rolls_and_answered_incorrectly(game)
            # Now it is Irrelevant Player's turn.

            # Irrelevant Player rolls the die and answers correctly.
            self.current_player_rolls_and_answers_correctly(game)
            # Now it is Current Player's turn.

            # Current Player rolls an odd number.
            game.roll(1)

            self.assertEqual('Current Player is getting out of the penalty box', game.commentary()[-4])
            self.assertEqual(True, game.is_getting_out_of_penalty_box)

    def test_current_player_moves_a_number_of_steps_forward_on_rolling_an_odd_number(self):
        with GameWithCommentary() as game:
            self.between(game, 'Current Player', 'Irrelevant Player')

            # Current Player's turn rolls the die and answers incorrectly, meaning they
            # are placed inside the penalty box.
            self.current_player_rolls_and_answered_incorrectly(game)

            # Irrelevant Player rolls the die and answers correctly.
            self.current_player_rolls_and_answers_correctly(game)

            # Current Player rolls an odd number.
            game.roll(1)

            self.assertEqual("Current Player's new location is 6", game.commentary()[-3])

    def test_current_player_is_asked_question_for_the_given_category_on_rolling_an_odd_number(self):
        with GameWithCommentary() as game:
            self.between(game, 'Current Player', 'Irrelevant Player')

            # Current Player's turn rolls the die and answers incorrectly, meaning they
            # are placed inside the penalty box.
            game.roll(4)
            game.wrong_answer()

            # Irrelevant Player rolls the die and answers correctly.
            self.current_player_rolls_and_answers_correctly(game)

            # Current Player rolls an odd number.
            game.roll(5)

            self.assertEqual("The category is Science", game.commentary()[-2])
            self.assertEqual("Science Question 1", game.commentary()[-1])

    def test_current_player_cannot_leave_penalty_box_on_rolling_an_even_number(self):
        with GameWithCommentary() as game:
            self.between(game, 'Current Player', 'Irrelevant Player')
            # Current Player's turn rolls the die and answers incorrectly, meaning they
            # are placed inside the penalty box.
            game.roll(6)
            game.wrong_answer()

            self.current_player_rolls_and_answers_correctly(game)
            # Current Player rolls an even number.
            game.roll(4)

            self.assertEqual("Current Player is not getting out of the penalty box", game.commentary()[-1])
            self.assertEqual(False, game.is_getting_out_of_penalty_box)

    def current_player_rolls_and_answered_incorrectly(self, game):
        game.roll(5)
        game.wrong_answer()

    def current_player_rolls_and_answers_correctly(self, game):
        irrelevant_die_face = 1
        game.roll(irrelevant_die_face)
        game.was_correctly_answered()


if __name__ == '__main__':
    unittest.main()
