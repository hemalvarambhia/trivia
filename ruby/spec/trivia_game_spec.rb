require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe "Playing Trivia" do
  describe 'How many players can play trivia' do
    example 'having 1 player in the game makes it unplayable' do
      game = UglyTrivia::Game.new

      game.add('Player 1')

      expect(game.is_playable?).to eq(false)
    end
    example 'up to 6 players can play the game'
    example 'the game can be played by more than 6 players'
  end

  describe 'Rolling the dice' do
    it 'advances the player a number of places as shown on the die'
    it 'returns the player to the starting square when they have moved 12 places'
  end
end