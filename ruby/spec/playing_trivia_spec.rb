describe 'How to play Trivia' do
  describe 'Number of players allowed' do
    specify 'A game consisting of no players is not allowed'
    specify 'A game consisting of two players is not allowed'
    specify 'A game consisting of more than two players (3) is allowed'
    specify 'A game consisting of six players is allowed'
    specify 'A game consisting of more than six players is allowed'
  end

  describe 'Rolling the dice' do
    specify 'Moves nowhere when a zero is rolled'
    specify 'Moves the number of places as shown on the face of the die'
  end
end