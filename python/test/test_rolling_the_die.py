import unittest

from trivia import Game
import sys

class GameWithCommentary(Game):
    pass


class TestRollingTheDie(unittest.TestCase):

    @unittest.skip("Not implemented")
    def test_that_rolling_die_reports_who_the_current_player_is(self):
        game = GameWithCommentary()
        game.add('Player 1')
        game.add('Player 2')

        game.roll(3)

        self.assertEqual('Player 1 is the current player', game.commentary)


if __name__ == '__main__':
    unittest.main()
