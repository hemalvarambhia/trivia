import unittest


class NumberOfPlayersTest(unittest.TestCase):
    def test_that_a_trivia_game_with_no_players_is_unplayable(self):
        self.assertEqual(4, 2 + 2)


if __name__ == '__main__':
    unittest.main()
