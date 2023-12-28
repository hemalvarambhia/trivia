require 'game_commentary'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  def initialize
    super
    @commentary = UglyTrivia::GameCommentary.new
  end

  def commentary
    @commentary.commentary
  end

  def puts(message)
    @commentary.puts(message)
  end
end
