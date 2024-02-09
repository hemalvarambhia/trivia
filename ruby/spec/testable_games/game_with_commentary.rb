require 'forwardable'
require 'string_io_based_game_commentator'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :commentary
  def initialize(
    deck_of_questions: UglyTrivia::DeckOfQuestions.new,
    commentary: UglyTrivia::StringIOBasedGameCommentator.new
  )
    super
  end
end
