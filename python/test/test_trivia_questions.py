import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary


class TestTriviaQuestions(unittest.TestCase):
    @parameterized.expand([0, 4, 8])
    def test_game_asks_current_player_a_pop_question_at_correct_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.between(players=['Irrelevant Player 1', 'Irrelevant Player 2'])

            game.roll(number_on_die)

            self.assertIn("The category is Pop", game.commentary())
            self.assertIn('Pop Question 0', game.commentary())

    def test_game_removes_pop_question_from_stack_once_it_is_asked(self):
        with GameWithCommentary() as game:
            game.between(players=['Irrelevant Player 1', 'Irrelevant Player 2'])

            game.roll(0)

            self.assertNotIn("Pop Question 0", game.pop_questions)

    @parameterized.expand([1, 5, 9])
    def test_game_asks_current_player_a_science_question_at_assigned_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.between(players=['Irrelevant Player 1', 'Irrelevant Player 2'])

            game.roll(number_on_die)

            self.assertIn('The category is Science', game.commentary())
            self.assertIn('Science Question 0', game.commentary())

    @parameterized.expand([2, 6, 10])
    def test_game_asks_current_player_a_sports_question_at_assigned_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.between(players=['Irrelevant Player 1', 'Irrelevant Player 2'])

            game.roll(number_on_die)

            self.assertIn('The category is Sports', game.commentary())
            self.assertIn('Sports Question 0', game.commentary())


if __name__ == '__main__':
    unittest.main()
