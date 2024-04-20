import unittest
from ugly_trivia.trivia import Game
import sys


class SilentGame(Game):
    def __init__(self):
        self._stdout = sys.stdout
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

        self.__assertHasPlayers(0, game)
        self.assertEqual(False, game.is_playable())

    def test_that_a_trivia_game_with_one_player_is_unplayable(self):
        with SilentGame() as game:
            game.add('Player 1')

            self.__assertHasPlayers(1, game)
            self.assertEqual(False, game.is_playable())

    def test_that_a_trivia_game_with_two_players_is_playable(self):
        with SilentGame() as game:
            game.add('Player 1')
            game.add('Player 2')

            self.__assertHasPlayers(2, game)
            self.__assertIsPlayable(game)

    def test_that_a_trivia_game_with_more_than_two_players_is_playable(self):
        game = (
            self.__game_with(['Player 1', 'Player 2', 'Player 3', 'Player 4']))

        self.__assertHasPlayers(4, game)
        self.__assertIsPlayable(game)

    def test_that_a_trivia_game_with_five_players_is_playable(self):
        game = (
            self.__game_with(['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5']))

        self.__assertHasPlayers(5, game)
        self.__assertIsPlayable(game)

    def test_that_six_players_cannot_play_trivia(self):
        self.assertRaises(IndexError, lambda: self.__game_with(
            ['Player A', 'Player B', 'Player C', 'Player D', 'Player E', 'Player F']))

    def test_that_more_than_six_players_cannot_play_trivia(self):
        self.assertRaises(IndexError, lambda: self.__game_with(
            ['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5', 'Player 6', 'Player 7']))

    def __game_with(self, players):
        with SilentGame() as game:
            for player in players:
                game.add(player)

        return game

    def __assertIsPlayable(self, game):
        self.assertEqual(True, game.is_playable())

    def __assertHasPlayers(self, expected, game):
        self.assertEqual(expected, game.how_many_players)


if __name__ == '__main__':
    unittest.main()
