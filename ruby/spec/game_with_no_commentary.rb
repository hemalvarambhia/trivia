require 'forwardable'
require 'no_game_commentary'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary, :puts, :commentary
  def initialize
    super()
    @commentary = UglyTrivia::NoGameCommentary.new
  end
end
