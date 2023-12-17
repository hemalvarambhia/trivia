require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe 'Deck of Questions' do
  subject(:deck_of_questions) { UglyTrivia::DeckOfQuestions.new }

  describe 'Deck of questions' do
    it "consists of 50 Science questions" do
      expected_questions = (0..49).map {|number| "Science Question #{number}"}
      expect(deck_of_questions.questions_for('Science')).to eq(expected_questions)
    end

    it "consists of 50 Pop questions" do
      expected_questions = (0..49).map {|number| "Pop Question #{number}"}
      expect(deck_of_questions.questions_for('Pop')).to eq(expected_questions)
    end

    it 'consists of 50 Sports questions' do

      expected_questions = (0..49).map {|number| "Sports Question #{number}"}
      expect(deck_of_questions.questions_for('Sports')).to eq(expected_questions)
    end

    it 'consists of 50 Rock questions' do
      expected_questions = (0..49).map {|number| "Rock Question #{number}"}
      expect(deck_of_questions.questions_for('Rock')).to eq(expected_questions)
    end
  end

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

  example "picking a question removes it from the deck" do
    question = deck_of_questions.pick_question_for 'Science'

    questions_for_category = deck_of_questions.questions_for('Science')
    expect(questions_for_category).not_to include(question)
  end
end
