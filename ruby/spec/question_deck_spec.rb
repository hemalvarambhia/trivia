require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe 'Deck of Questions' do
  describe 'A player is asked science questions when:' do
    example 'they have moved one place from the start' do
      category = UglyTrivia::Game.current_category(1)

      expect(category).to eq('Science')
    end

    example 'they have moved 5 spaces forwards from the start' do
      category = UglyTrivia::Game.current_category(5)

      expect(category).to eq('Science')
    end

    it 'they have moved 9 spaces forwards from the start' do
      category = UglyTrivia::Game.current_category(9)

      expect(category).to eq('Science')
    end
  end
end
