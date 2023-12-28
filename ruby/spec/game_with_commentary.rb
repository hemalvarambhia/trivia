require 'forwardable'
require 'game_commentary'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize(commentary: UglyTrivia::GameCommentary.new)
    @commentary = commentary
    super()
  end
end
