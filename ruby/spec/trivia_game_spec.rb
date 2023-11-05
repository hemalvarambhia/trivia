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

    it 'awards the player a gold coin when they answer the question correctly' do
      game = game_with(['Player 1', 'Player 2'])

      game.roll(1)
      game.was_correctly_answered

      purses = game.purses
      expect(purses[0]).to eq(1)
    end

    it 'places the player in the penalty box when the answer to the question is wrong'
    it 'returns the player to the starting square when they have moved 12 places'
  end
end