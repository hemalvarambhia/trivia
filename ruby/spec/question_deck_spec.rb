require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe 'Deck of Questions' do
  subject(:deck_of_questions) { UglyTrivia::DeckOfQuestions.new }

  describe 'Deck of questions by default' do
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

  ['Science', 'Pop', 'Rock'].each do |category|
    example "picking a #{category} question from the deck removes it so it isn't asked again" do
      question = deck_of_questions.pick_question_for category

      questions_for_category = deck_of_questions.questions_for(category)
      expect(question).to eq("#{category} Question 0")
      expect(questions_for_category).not_to include("#{category} Question 0")
    end

    it "takes #{category} questions from the deck until there are none left" do
      50.times { deck_of_questions.pick_question_for(category) }

      expect(deck_of_questions.questions_for(category)).to be_empty
    end

    it "takes no question for #{category} from the deck when there are none left" do
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
