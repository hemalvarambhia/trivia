import unittest
from ugly_trivia.trivia import Game


class NumberOfPlayersTest(unittest.TestCase):
    def test_that_a_trivia_game_with_no_players_is_unplayable(self):
        game = Game()
        self.assertEqual(False, game.is_playable())
        self.assertEqual(0, game.how_many_players)

    def test_that_a_trivia_game_with_one_player_is_unplayable(self):
        game = self.__game_with(['Player 1'])

        self.assertEqual(False, game.is_playable())
        self.assertEqual(1, game.how_many_players)

    def test_that_a_trivia_game_with_two_players_is_playable(self):
        game = self.__game_with(['Player 1', 'Player 2'])

        self.assertEqual(True, game.is_playable())
        self.assertEqual(2, game.how_many_players)

    def test_that_a_trivia_game_with_more_than_two_players_is_playable(self):
        game = self.__game_with(['Player 1', 'Player 2', 'Player 3', 'Player 4'])

        self.assertEqual(True, game.is_playable())
        self.assertEqual(4, game.how_many_players)

    def __game_with(self, players):
        game = Game()
        for player in players:
            game.add(player)

        return game


if __name__ == '__main__':
    unittest.main()
