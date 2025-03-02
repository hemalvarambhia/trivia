import io
import unittest
from contextlib import redirect_stdout

from test.game_with_commentary import GameWithCommentary


class TestAnsweringQuestionsFromInsidePenaltyBox(unittest.TestCase):
    def test_answering_question_correctly_allows_current_player_to_leave_penalty_box_but_is_getting_out_of_penalty_box_is_unchanged(self):
        def is_getting_out_of_penalty_box(trivia_game): return getattr(trivia_game, "is_getting_out_of_penalty_box")
        with (io.StringIO() as fake_out, redirect_stdout(fake_out)):
            game = GameWithCommentary()
            game.between(["Player 1", "Player 2"])

            game.roll(2)
            game.wrong_answer()

            game.roll(1)
            game.was_correctly_answered()

            game.roll(1)

            self.assertUnchanged(
                attribute=lambda: is_getting_out_of_penalty_box(game),
                code_block=lambda: game.was_correctly_answered()
            )

    @unittest.skip("TODO")
    def test_answering_question_correctly_wins_current_player_a_gold_coin(self):
        pass

    @unittest.skip("TODO")
    def test_answering_question_incorrectly_keeps_current_player_in_penalty_box(self):
        pass

    def assertUnchanged(self, attribute, code_block):
        self.assertChanges(attribute, 0, code_block)

    def assertChanges(self, attribute, by, code_block):
        before = attribute()

        code_block()

        after = attribute()

        self.assertEqual(by, after - before)


if __name__ == '__main__':
    unittest.main()
