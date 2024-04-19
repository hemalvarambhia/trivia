import unittest

from parameterized import parameterized
from test.game_with_commentary import GameWithCommentary


class TestRollingTheDieOutsidePenaltyBox(unittest.TestCase):

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

            self.assertEqual('They have rolled a 4', game.commentary()[-4])

    def test_game_reports_the_current_players_new_location_on_the_board(self):
        with GameWithCommentary() as game:
            game.add('Player 1')
            game.add('Player 2')

            game.roll(6)

            self.assertEqual("Player 1's new location is 6", game.commentary()[-3])

    def test_game_asks_current_player_the_category_of_question_for_their_location_on_the_board(self):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(6)

            self.assertEqual("The category is Sports", game.commentary()[-2])
            self.assertEqual("Sports Question 0", game.commentary()[-1])

    @parameterized.expand([0, 4, 8])
    def test_game_asks_current_player_a_pop_question_at_correct_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(number_on_die)

            self.assertIn("The category is Pop", game.commentary())
            self.assertIn('Pop Question 0', game.commentary())

    def test_game_removes_pop_question_from_stack_once_it_is_asked(self):
        with GameWithCommentary() as game:
            game.add('Irrelevant Player 1')
            game.add('Irrelevant Player 2')

            game.roll(0)

            self.assertNotIn("Pop Question 0", game.pop_questions)

    @parameterized.expand([1, 5, 9])
    def test_game_asks_current_player_a_science_question_at_assigned_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            self.between(game, 'Irrelevant Player 1', 'Irrelevant Player 2')

            game.roll(number_on_die)

            self.assertIn('The category is Science', game.commentary())
            self.assertIn('Science Question 0', game.commentary())

    @parameterized.expand([2, 6, 10])
    def test_game_asks_current_player_a_sports_question_at_assigned_locations_on_the_board(self, number_on_die):
        with GameWithCommentary() as game:
            self.between(game, 'Irrelevant Player 1', 'Irrelevant Player 2')

            game.roll(number_on_die)

            self.assertIn('The category is Sports', game.commentary())
            self.assertIn('Sports Question 0', game.commentary())

    # Clients can make the current player roll twice, as long as
    def test_game_brings_player_up_to_the_last_location_eleven_on_the_board(self):
        with GameWithCommentary() as game:
            self.between(game, 'Player 1', 'Irrelevant Player 2')
            game.roll(5)  # Player 1 location 5
            game.roll(6)  # Player 1 location 11

            self.assertIn("Player 1's new location is 11", game.commentary())

    def test_game_returns_current_player_to_the_starting_square_of_the_board_when_they_are_initially_at_square_eleven(self):
        with GameWithCommentary() as game:
            self.between(game, 'Player 1', 'Irrelevant Player 2')
            game.roll(5) # Player 1 location 5
            game.roll(6) # Player 1 location 11

            game.roll(1) # Player 1 location 0, back to starting position

            self.assertIn("Player 1's new location is 0", game.commentary())

    def test_game_brings_current_player_to_next_square_after_the_start_with_they_are_initially_at_location_eleven(self):
        with GameWithCommentary() as game:
            self.between(game, 'Player 1', 'Irrelevant Player')
            game.roll(5)  # Player 1 location 5
            game.roll(6)  # Player 1 location 11

            game.roll(3)  # Player 1 location 2

            self.assertIn("Player 1's new location is 2", game.commentary())

    def between(self, game, player1, player2):
        game.add(player1)
        game.add(player2)

if __name__ == '__main__':
    unittest.main()
