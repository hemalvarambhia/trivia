import unittest


class PlayTriviaTest(unittest.TestCase):
    def between(self, game, player1, player2):
        game.add(player1)
        game.add(player2)


if __name__ == '__main__':
    unittest.main()
