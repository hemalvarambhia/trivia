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

  ['Science'].each do |category|
    example "picking a question from the deck removes it" do
      question = deck_of_questions.pick_question_for category

      questions_for_category = deck_of_questions.questions_for(category)
      expect(question).to eq("#{category} Question 0")
      expect(questions_for_category).not_to include("#{category} Question 0")
    end

    it 'takes questions from the deck until there are none left' do
      50.times { deck_of_questions.pick_question_for(category) }

      expect(deck_of_questions.questions_for(category)).to be_empty
    end

    it 'takes no question for a category from the deck when there are none left' do
      50.times { deck_of_questions.pick_question_for(category) }

      question = deck_of_questions.pick_question_for(category)

      expect(question).to be_nil
    end
  end

  example "picking several questions in succession from the deck removes them" do
    3.times { deck_of_questions.pick_question_for 'Science' }

    questions_for_category = deck_of_questions.questions_for('Science')
    expect(questions_for_category).not_to include('Science Question 0', 'Science Question 1', 'Science Question 2')
  end
end
