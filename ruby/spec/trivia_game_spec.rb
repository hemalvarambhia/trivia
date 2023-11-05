require 'spec_helper'

describe "Playing Trivia" do
  describe 'How many players can play trivia' do
    example 'having 1 player in the game makes it unplayable'
    example 'up to 6 players can play the game'
    example 'the game can be played by more than 6 players'
  end

  describe 'Rolling the dice' do
    it 'advances the player a number of places as shown on the die'
    it 'returns the player to the starting square when they have moved 12 places'
  end
end