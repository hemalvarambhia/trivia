import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary


class TestRollingTheDie(unittest.TestCase):

    def test_game_reports_who_the_current_player_is(self):
        with GameWithCommentary() as game:
            game.add('Player 1')
            game.add('Player 2')

            game.roll(3)

            self.assertIn('Player 1 is the current player', game.commentary())

    def test_game_reports_the_face_the_die_landed_on(self):
        with GameWithCommentary() as game:
            game.add('Player 1')
            game.add('Player 2')

            game.roll(4)

            self.assertIn('They have rolled a 4', game.commentary())

    def test_game_reports_the_players_new_location_on_the_board(self):
        with GameWithCommentary() as game:
            game.add('Player 1')
            game.add('Player 2')

            game.roll(6)

            self.assertIn("Player 1's new location is 6", game.commentary())

    def test_game_asks_the_category_of_question_for_their_location_on_the_board_for_example_sports(self):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(6)

            self.assertIn("The category is Sports", game.commentary())
            self.assertIn("Sports Question 0", game.commentary())

    def test_game_removes_pop_question_from_stack_once_it_is_asked(self):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(0)

            self.assertNotIn("Pop Question 0", game.pop_questions)

    @parameterized.expand([0, 4, 8])
    def test_game_asks_pop_questions_at_correct_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(number_on_die)

            self.assertIn("The category is Pop", game.commentary())
            self.assertIn('Pop Question 0', game.commentary())

    @parameterized.expand([1, 5, 9])
    def test_game_asks_science_questions_at_assigned_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(number_on_die)

            self.assertIn('The category is Science', game.commentary())
            self.assertIn('Science Question 0', game.commentary())


if __name__ == '__main__':
    unittest.main()
