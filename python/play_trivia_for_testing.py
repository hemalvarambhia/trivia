#!/usr/bin/env python
from random import randrange
from random import Random

from trivia import Game

if __name__ == '__main__':
    not_a_winner = False

    game = Game()

    game.add('Chet')
    game.add('Pat')
    game.add('Sue')
    random_number = Random(7777)

    while True:
        game.roll(random_number.randrange(5) + 1)

        if random_number.randrange(9) == 7:
            not_a_winner = game.wrong_answer()
        else:
            not_a_winner = game.was_correctly_answered()

        if not not_a_winner: break