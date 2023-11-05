require 'spec_helper'

describe "Playing Trivia" do
  describe 'How many players can play trivia' do
    example 'having 1 player in the game makes it unplayable'
    example 'up to 6 players can play the game'
    example 'the game can be played by more than 6 players'
  end

  describe 'Rolling the dice' do
    it 'advances the player a number of places as shown on the die'
  end
end