import unittest
from ugly_trivia.trivia import Game
import sys


class SilentGame(Game):
    def __init__(self):
        self._stdout = sys.stdout
        self._commentary = []
        super().__init__()

    def __enter__(self):
        sys.stdout = self
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        sys.stdout = self._stdout

    def write(self, text):
        pass


class TestNumberOfPlayers(unittest.TestCase):
    def test_that_a_trivia_game_with_no_players_is_unplayable(self):
        game = Game()
        self.assertEqual(False, game.is_playable())
        self.assertEqual(0, game.how_many_players)

    def test_that_a_trivia_game_with_one_player_is_unplayable(self):
        with SilentGame() as game:
            game.add('Player 1')

            self.assertEqual(False, game.is_playable())
            self.assertEqual(1, game.how_many_players)

    def test_that_a_trivia_game_with_two_players_is_playable(self):
        with SilentGame() as game:
            game.add('Player 1')
            game.add('Player 2')

            self.assertEqual(True, game.is_playable())
            self.assertEqual(2, game.how_many_players)

    def test_that_a_trivia_game_with_more_than_two_players_is_playable(self):
        game = self.__game_with(['Player 1', 'Player 2', 'Player 3', 'Player 4'])

        self.assertEqual(True, game.is_playable())
        self.assertEqual(4, game.how_many_players)

    def test_that_a_trivia_game_with_five_players_is_playable(self):
        game = self.__game_with(['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5'])

        self.assertEqual(True, game.is_playable())
        self.assertEqual(5, game.how_many_players)

    def test_that_six_players_cannot_play_trivia(self):
        game_with_six_players = lambda: self.__game_with(
            ['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5', 'Player 6'])

        self.assertRaises(IndexError, game_with_six_players)

    def test_that_more_than_six_players_cannot_play_trivia(self):
        game_with_more_than_six_players = lambda: self.__game_with(
            ['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5', 'Player 6', 'Player 7'])

        self.assertRaises(IndexError, game_with_more_than_six_players)

    def __game_with(self, players):
        game = Game()
        for player in players:
            game.add(player)

        return game


if __name__ == '__main__':
    unittest.main()
