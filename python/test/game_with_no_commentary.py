from ugly_trivia.trivia import Game


class GameWithNoCommentary(Game):

    def between(self, players):
        for player in players:
            self.add(player)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        pass
