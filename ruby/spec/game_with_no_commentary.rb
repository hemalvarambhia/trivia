require 'forwardable'
require 'no_game_commentary'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize(commentary: UglyTrivia::NoGameCommentary.new)
    super()
    @commentary = commentary
  end
end
