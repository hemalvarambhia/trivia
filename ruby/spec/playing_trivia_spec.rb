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
      players = ['Khushboo', 'Benton']
      players.each { |player| game_with_two_players.add player }

      expect(game_with_two_players.how_many_players).to eq 2
      expect(game_with_two_players.is_playable?).to be true
    end

    specify 'A game consisting of more than two players (e.g. 3) is allowed' do
      game_with_more_than_two_players = UglyTrivia::Game.new
      game_with_more_than_two_players.add('Jane')
      game_with_more_than_two_players.add('James')
      game_with_more_than_two_players.add('Jennifer')

      expect(game_with_more_than_two_players.how_many_players).to eq 3
      expect(game_with_more_than_two_players.is_playable?).to be true
    end

    specify 'A game consisting of six players is allowed' do
      game_with_six_players = UglyTrivia::Game.new
      players = [
        'Marlon',
        'Maxine',
        'José',
        'Maria',
        'Rajiv',
        'Karina'
      ]
      players.each do |player|
        game_with_six_players.add(player)
      end

      expect(game_with_six_players.how_many_players).to eq 6
      expect(game_with_six_players.is_playable?).to be true
    end

    specify 'A game consisting of more than six players (e.g. 7) is allowed' do
      game_with_more_than_six_players = UglyTrivia::Game.new
      players = (1..7).map {|number| "Player #{number}" }
      players.each do |player|
        game_with_more_than_six_players.add(player)
      end

      expect(game_with_more_than_six_players.how_many_players).to eq 7
      expect(game_with_more_than_six_players.is_playable?).to be true
    end
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