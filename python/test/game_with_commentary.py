from ugly_trivia.trivia import Game
import sys

class GameWithCommentary(Game):
    def __init__(self):
        self._stdout = sys.stdout
        self._commentary = []
        super().__init__()

    def __enter__(self):
        sys.stdout = self
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        sys.stdout = self._stdout

    def write(self, text):
        self._commentary.append(text)

    def flush(self):
        pass  # This method is required but does nothing in this example

    def commentary(self):
        return list(filter(lambda item: item != '\n', self._commentary))
