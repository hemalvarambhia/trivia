import io
import unittest
from contextlib import redirect_stdout

from test.game_with_commentary import GameWithCommentary


class TestAnsweringTriviaQuestions(unittest.TestCase):

    def test_answering_trivia_question_correctly_wins_current_player_a_gold_coin(self):
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(['Player 1', 'Irrelevant'])
            game.roll(2)

            game.was_correctly_answered()

            self.assertEqual(1, game.purses[0])

    @unittest.skip('Test list')
    def test_answering_trivia_question_correctly_keeps_current_player_out_of_penalty_box(self):
        pass

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_places_current_player_in_penalty_box(self):
        pass

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_does_not_award_player_a_gold_coin(self):
        pass