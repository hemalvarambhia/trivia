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
    example 'the game can be played by more than 6 players'
  end

  describe 'Rolling the dice' do
    it 'advances the player a number of places as shown on the die'
    it 'returns the player to the starting square when they have moved 12 places'
  end
end