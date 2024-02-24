#!/usr/bin/env python
import argparse
from random import randrange
from random import Random

from ugly_trivia.trivia import Game

parser = argparse.ArgumentParser(description='Play a game of Trivia.')
parser.add_argument('--seed', metavar='seed', type=int, nargs='+',
                    help='a seed to start the game')

if __name__ == '__main__':
    not_a_winner = False

    game = Game()

    game.add('Chet')
    game.add('Pat')
    game.add('Sue')
    seed = parser.parse_args().seed[0]
    random_number = Random(seed)

    while True:
        game.roll(random_number.randrange(5) + 1)

        if random_number.randrange(9) == 7:
            not_a_winner = game.wrong_answer()
        else:
            not_a_winner = game.was_correctly_answered()

        if not not_a_winner: break