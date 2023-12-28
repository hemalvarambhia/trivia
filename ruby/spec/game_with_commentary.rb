require 'forwardable'
require 'string_io_based_game_commentator'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize(commentary: UglyTrivia::StringIOBasedGameCommentator.new)
    @commentary = commentary
    super()
  end
end
