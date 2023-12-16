require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe 'Deck of Questions' do
  subject(:deck_of_questions) { DeckOfQuestions.new }

  describe 'A player is asked science questions when:' do
    example 'they have moved one place from the start' do
      category = deck_of_questions.current_category(1)

      expect(category).to eq('Science')
    end

    example 'they have moved 5 spaces forwards from the start' do
      category = deck_of_questions.current_category(5)

      expect(category).to eq('Science')
    end

    it 'they have moved 9 spaces forwards from the start' do
      category = deck_of_questions.current_category(9)

      expect(category).to eq('Science')
    end
  end

  describe 'A player is asked pop questions when:' do
    example 'they are at the start' do
      category = deck_of_questions.current_category(0)

      expect(category).to eq('Pop')
    end

    example 'they have moved 4 places from the start' do
      category = deck_of_questions.current_category(4)

      expect(category).to eq('Pop')
    end

    example 'they have moved 8 places from the start' do
      category = deck_of_questions.current_category(8)

      expect(category).to eq('Pop')
    end
  end

  describe 'A player is asked a sports question when:' do
    example 'they have moved 2 places from the start' do
      category = deck_of_questions.current_category(2)

      expect(category).to eq('Sports')
    end

    example 'they have moved 6 places from the start' do
      category = deck_of_questions.current_category(6)

      expect(category).to eq('Sports')
    end

    example 'they have moved 10 places from the start' do
      category = deck_of_questions.current_category(10)

      expect(category).to eq('Sports')
    end
  end

  describe 'A player is asked a rock question when:' do
    example 'when they have moved 3 places from the start' do
      category = deck_of_questions.current_category(3)

      expect(category).to eq('Rock')
    end
    example 'when they have moved 7 places from the start' do
      category = deck_of_questions.current_category(7)

      expect(category).to eq('Rock')
    end

    example 'when they have moved 11 places from the the start' do
      category = deck_of_questions.current_category(11)

      expect(category).to eq('Rock')
    end
  end
end
