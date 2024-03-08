import unittest

from test.game_with_commentary import GameWithCommentary


class TestRollingTheDie(unittest.TestCase):

    def test_that_rolling_die_reports_who_the_current_player_is(self):
        with GameWithCommentary() as game:
            game.add('Player 1')
            game.add('Player 2')

            game.roll(3)

            self.assertIn('Player 1 is the current player', game.commentary())

    @unittest.skip('Next test to get passing')
    def test_that_rolling_die_reports_the_face_the_die_landed_on(self):
        pass

if __name__ == '__main__':
    unittest.main()
