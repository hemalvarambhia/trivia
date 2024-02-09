require 'forwardable'
require 'no_game_commentator'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :commentary
  def initialize(
    deck_of_questions: UglyTrivia::DeckOfQuestions.new,
    commentary: UglyTrivia::NoGameCommentator.new)
    super
  end
end
