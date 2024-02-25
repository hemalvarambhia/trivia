import unittest
from ugly_trivia.trivia import Game


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

    def test_that_a_trivia_game_with_two_players_is_playable(self):
        game = Game()
        game.add('Player 1')
        game.add('Player 2')

        self.assertEqual(True, game.is_playable())
        self.assertEqual(2, game.how_many_players)

    def test_that_a_trivia_game_with_more_than_two_players_is_playable(self):
        game = Game()
        game.add('Player 1')
        game.add('Player 2')
        game.add('Player 3')
        game.add('Player 4')

        self.assertEqual(True, game.is_playable())
        self.assertEqual(4, game.how_many_players)


if __name__ == '__main__':
    unittest.main()
