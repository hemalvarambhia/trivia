import unittest


class PlayTriviaTest(unittest.TestCase):
    def between(self, game, player1 = None, player2 = None, players = []):
        if len(players) == 0:
            game.add(player1)
            game.add(player2)
        else:
            for player in players:
                game.add(player)


if __name__ == '__main__':
    unittest.main()
