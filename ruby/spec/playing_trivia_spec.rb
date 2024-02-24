require_relative '../lib/ugly_trivia/game'

module UglyTrivia
  class SilentGame < UglyTrivia::Game
    def puts(_)
      # no op
    end
  end
end

module UglyTrivia
  class GameWithCommentary < Game
    def initialize
      super
      @commentary = StringIO.new
    end

    def puts(message)
      @commentary.puts message
    end

    def commentary
      @commentary.string.split("\n")
    end
  end
end

describe 'How to play Trivia' do
  describe 'Number of players allowed' do
    specify 'A game consisting of no players is not allowed' do
      game_with_no_players = silent_game_with([])

      expect(game_with_no_players.how_many_players).to eq 0
      expect(game_with_no_players.is_playable?).to be false
    end

    specify 'A game consisting of two players is allowed' do
      players = ['Player 1', 'Player 2']
      game_with_two_players = silent_game_with(players)

      expect(game_with_two_players.how_many_players).to eq 2
      expect(game_with_two_players.is_playable?).to be true
    end

    specify 'A game consisting of more than two players (e.g. 3) is allowed' do
      players = ['Player 1', 'Player 2', 'Player 3']
      game_with_more_than_two_players = silent_game_with(players)

      expect(game_with_more_than_two_players.how_many_players).to eq 3
      expect(game_with_more_than_two_players.is_playable?).to be true
    end

    specify 'A game consisting of six players is allowed' do
      players = (1..6).map { |number| "Player #{number}"}
      game_with_six_players = silent_game_with(players)

      expect(game_with_six_players.how_many_players).to eq 6
      expect(game_with_six_players.is_playable?).to be true
    end

    specify 'A game consisting of more than six players (e.g. 7) is allowed' do
      players = (1..7).map {|number| "Player #{number}" }
      game_with_more_than_six_players = silent_game_with(players)

      expect(game_with_more_than_six_players.how_many_players).to eq 7
      expect(game_with_more_than_six_players.is_playable?).to be true
    end
  end

  describe 'Rolling the dice' do
    specify 'Reports who the current player is and the number they rolled' do
      game = game_with_commentary_and_players(['Player 1', 'Player 2'])

      game.roll 5

      expect(game.commentary).to include("Player 1 is the current player")
      expect(game.commentary).to include("They have rolled a 5")
    end

    specify 'Moves the current player nowhere when a zero is rolled' do
      game = game_with_commentary_and_players(['Player 1', 'Player 2'])

      player_1 = 0
      expect { game.roll 0 }.not_to change { game.places[player_1] }
    end

    context 'Given the player has rolled an odd number' do
      specify 'Moves the current player a number of places as shown on the face of the die'
      specify 'Does not move any other player from their current place'
      specify 'Rolling a negative number moves the current player backwards by that number'
      specify "Reports the current player's new location"
      specify "Reports the category of question that will be asked to the current player"
      specify "Asks the current player a question from the category for their current location"
    end
  end

  private

  def silent_game_with(players)
    UglyTrivia::SilentGame.new.tap do |game|
      players.each { |player| game.add player }
    end
  end

  def game_with_commentary_and_players(players)
    UglyTrivia::GameWithCommentary.new.tap do |game|
      players.each { |player| game.add player }
    end
  end
end