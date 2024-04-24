import unittest
from ugly_trivia.trivia import Game
from contextlib import redirect_stdout
import io
from test.game_with_commentary import GameWithCommentary


class TestAnsweringTriviaQuestions(unittest.TestCase):
    @unittest.skip('Test list')
    def test_answering_trivia_question_correctly_wins_current_player_a_gold_coin(self):
        pass

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_places_current_player_in_penalty_box(self):
        pass

    @unittest.skip('Test list')
    def test_answering_trivia_question_incorrectly_does_not_award_player_a_gold_coin(self):
        pass