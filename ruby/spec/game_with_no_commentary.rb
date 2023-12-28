require 'forwardable'
require 'no_game_commentator'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize(commentary: UglyTrivia::NoGameCommentator.new)
    super()
    @commentary = commentary
  end
end
