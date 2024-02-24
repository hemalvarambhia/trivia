import unittest
from trivia import Game


class NumberOfPlayersTest(unittest.TestCase):
    def test_that_a_trivia_game_with_no_players_is_unplayable(self):
        game = Game()
        self.assertEqual(False, game.is_playable())


if __name__ == '__main__':
    unittest.main()
