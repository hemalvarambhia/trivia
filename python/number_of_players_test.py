import unittest
from trivia import Game


class NumberOfPlayersTest(unittest.TestCase):
    def test_that_a_trivia_game_with_no_players_is_unplayable(self):
        game = Game()
        self.assertEqual(False, game.is_playable())
        self.assertEqual(0, game.how_many_players)

    def test_that_a_trivia_game_with_one_player_is_unplayable(self):
        game = Game()
        game.add('Player 1')

        self.assertEqual(False, game.is_playable())
        self.assertEqual(1, game.how_many_players)


if __name__ == '__main__':
    unittest.main()
