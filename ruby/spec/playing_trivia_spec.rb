require_relative '../lib/ugly_trivia/game'
describe 'How to play Trivia' do
  describe 'Number of players allowed' do
    specify 'A game consisting of no players is not allowed' do
      game_with_no_players = UglyTrivia::Game.new

      expect(game_with_no_players.how_many_players).to eq 0
      expect(game_with_no_players.is_playable?).to be false
    end

    specify 'A game consisting of two players is allowed' do
      game_with_two_players = UglyTrivia::Game.new
      game_with_two_players.add('Khushboo')
      game_with_two_players.add('Benton')

      expect(game_with_two_players.how_many_players).to eq 2
      expect(game_with_two_players.is_playable?).to eq true
    end

    specify 'A game consisting of more than two players (3) is allowed'
    specify 'A game consisting of six players is allowed'
    specify 'A game consisting of more than six players is allowed'
  end

  describe 'Rolling the dice' do
    specify 'Reports who the current player is'
    specify 'Reports the number the current player rolled'

    specify 'Moves the current player nowhere when a zero is rolled'

    context 'Given the player has rolled an odd number' do
      specify 'Moves the current player a number of places as shown on the face of the die'
      specify 'Does not move any other player from their current place'
      specify 'Rolling a negative number moves the current player backwards by that number'
      specify "Reports the current player's new location"
      specify "Reports the category of question that will be asked to the current player"
      specify "Asks the current player a question from the category for their current location"
    end
  end
end