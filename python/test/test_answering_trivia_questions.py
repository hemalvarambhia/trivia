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

            self.assertChangesBy(game, "purses", 1, lambda: game.was_correctly_answered())

    @unittest.skip('Test list')
    def test_answering_trivia_question_correctly_keeps_current_player_out_of_penalty_box(self):
        pass

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_places_current_player_in_penalty_box(self):
        pass

    def test_answering_trivia_question_incorrectly_does_not_award_player_a_gold_coin(self):
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(['Player 1', 'Irrelevant'])
            game.roll(2)

            self.assertChangesBy(game, "purses", 0, lambda: game.wrong_answer())

    def assertChangesBy(self, game, property, change, code_block):
        before = getattr(game, property)[0]

        code_block()

        after = getattr(game, property)[0]

        self.assertEqual(change, after - before)
