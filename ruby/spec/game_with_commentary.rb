require 'forwardable'
require 'string_io_based_game_commentary'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize(commentary: UglyTrivia::StringIOBasedGameCommentary.new)
    @commentary = commentary
    super()
  end
end
