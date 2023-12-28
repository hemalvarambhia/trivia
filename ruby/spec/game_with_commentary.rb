class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  def initialize
    super
    @commentary = StringIO.new
  end

  def commentary
    @commentary.string.split("\n")
  end

  def puts(message)
    @commentary.puts(message)
  end
end
