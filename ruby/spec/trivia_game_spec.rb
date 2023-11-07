require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe "Playing Trivia" do
  describe 'How many players can play trivia' do
    it 'is not a 1-player game' do
      game = UglyTrivia::Game.new

      game.add('Player 1')

      expect(game.is_playable?).to eq(false)
    end

    it 'requires a minimum of 2 players' do
      game = UglyTrivia::Game.new

      game.add('Player 1')
      game.add('Player 2')

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by exactly 6 players' do
      game = UglyTrivia::Game.new

      6.times { |number| game.add("Player #{number + 1}") }

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by more than 6 players' do
      game = UglyTrivia::Game.new

      7.times { |number| game.add("Player #{number + 1}") }

      expect(game.is_playable?).to eq(true)
    end
  end

  describe 'Rolling the die' do
    def game_with(players)
      UglyTrivia::Game.new.tap do |trivia|
        players.each { |player| trivia.add(player) }
      end
    end

    example 'the starting category is Pop' do
      game = game_with(['Player 1', 'Player 2'])

      category = game.send(:current_category)
      expect(category).to eq('Pop')
    end

    it 'advances a player a number of places as shown on the die' do
      game = game_with(['Player 1', 'Player 2'])

      game.roll(1)

      places = game.places
      expect(places[0]).to eq(1)
    end

    it 'asks the player a question from the current category based on what place the player is at' do
      game = game_with(['Player 1', 'Player 2'])

      game.roll(1)

      category = game.send(:current_category)
      expect(category).to eq('Science')
    end

    it 'asks the player a science question when they have moved 5 spaces forwards from the start'
    it 'asks the player a science question when they have moved 9 spaces forwards from the start'

    context 'when a player answers their question correctly' do
      it 'awards that player a gold coin' do
        game = game_with(['Player 1', 'Player 2'])

        game.roll(1)
        game.was_correctly_answered

        purses = game.purses
        player_1 = 0
        expect(purses[player_1]).to eq(1)
      end

      it 'is the next players turn' do
        game = game_with(['Player 1', 'Player 2'])

        game.roll(1)
        game.was_correctly_answered

        current_player = game.current_player
        player_2 = 1
        expect(current_player).to eq(player_2)
      end
    end

    context 'when a player answers their question incorrectly' do
      it 'places the player in the penalty box when the answer to the question is wrong' do
        game = game_with(['Player 1', 'Player 2'])
        game.roll(2)
        game.wrong_answer

        player_1 = 0
        player_in_penalty_box = game.in_penalty_box[player_1]
        expect(player_in_penalty_box).to eq(true)
      end

      it 'is the next players turn'
    end

    it 'returns the player to the starting square when they have moved 12 places' do
      game = game_with(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(6)

      places = game.places
      player_1 = 0
      expect(places[player_1]).to eq(0)
    end

    example 'a player can cycle around the board multiple times, every 12 places' do
      game = game_with(['Player 1', 'Player 2'])

      3.times do
        game.roll(6)
        game.roll(6)
      end

      places = game.places
      player_1 = 0
      expect(places[player_1]).to eq(0)
    end
  end
end