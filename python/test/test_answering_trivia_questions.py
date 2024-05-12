import io
import unittest
from contextlib import redirect_stdout

from test.game_with_commentary import GameWithCommentary


class TestAnsweringTriviaQuestions(unittest.TestCase):

    def test_answering_trivia_question_correctly_wins_current_player_a_gold_coin(self):
        def purses(trivia_game): return getattr(trivia_game, "purses")
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(['Player 1', 'Irrelevant'])
            game.roll(2)

            self.assertChanges(
                attribute=lambda: purses(game)[0], by=1,
                code_block=lambda: game.was_correctly_answered()
            )

    def test_answering_trivia_question_correctly_keeps_current_player_out_of_penalty_box(self):
        def in_penalty_box(trivia_game): return getattr(trivia_game, "in_penalty_box")
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(['Player 1', 'Irrelevant'])
            game.roll(2)

            current_player = 0
            self.assertUnchanged(
                attribute=lambda: in_penalty_box(game)[current_player],
                code_block=lambda: game.was_correctly_answered()
            )

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_places_current_player_in_penalty_box(self):
        pass

    def test_answering_trivia_question_incorrectly_does_not_award_player_a_gold_coin(self):
        def purse(trivia_game): return getattr(trivia_game, "purses")
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(['Player 1', 'Irrelevant'])
            game.roll(2)

            self.assertChanges(
                attribute=lambda: purse(game)[0], by=0,
                code_block=lambda: game.wrong_answer()
            )

    def assertChanges(self, attribute, by, code_block):
        before = attribute()

        code_block()

        after = attribute()

        self.assertEqual(by, after - before)

    def assertUnchanged(self, attribute, code_block):
        before = attribute()

        code_block()

        after = attribute()

        self.assertEqual(0, after - before)
