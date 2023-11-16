require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

describe "Playing Trivia" do
  class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
    def puts(message)
      # do nothing
    end
  end

  class UglyTrivia::GameWithCommentary < UglyTrivia::Game
    def initialize
      super
      @commentary = StringIO.new
    end

    def commentary
      @commentary.string
    end

    def puts(message)
      @commentary.puts(message)
    end
  end

  def game_without_commentary_involving(players)
    UglyTrivia::GameWithNoCommentary.with(players)
  end

  def current_category(game)
    game.send(:current_category)
  end

  describe 'How many players can play trivia' do
    it 'is not a 1-player game' do
      game = game_without_commentary_involving(['Player 1'])

      expect(game.is_playable?).to eq(false)
    end

    it 'requires a minimum of 2 players' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by exactly 6 players' do
      players = (1..6).map {|number| "Player #{number}"}
      game = game_without_commentary_involving(players)

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by more than 6 players' do
      players = (1..7).map {|number| "Player #{number}"}
      game = game_without_commentary_involving(players)

      expect(game.is_playable?).to eq(true)
    end
  end

  context 'Trivia game involving three players' do
    it 'has no one in the penalty box at the beginning' do
      game = game_without_commentary_involving(['Player 1', 'Player 2', 'Player 3'])

      expect(game.in_penalty_box[1..3]).to all eq(false)
      # This part feels odd.
      expect(game.in_penalty_box.first).to be_nil
      expect(game.in_penalty_box[-2]).to be_nil
      expect(game.in_penalty_box[-1]).to be_nil
    end
  end

  context 'Trivial game involving six players' do
    it 'has no one in the penalty box at the beginning' do
      players = (1..6).map {|number| "Player #{number}"}
      game = game_without_commentary_involving(players)

      expect(game.in_penalty_box[1..-1]).to all eq(false)
      expect(game.in_penalty_box.first).to be_nil
    end
  end

  describe 'Rolling the die' do
    it 'does not advance a player when they roll a 0'
    it 'advances a player a number of places as shown on the die' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(1)

      places = game.places
      expect(places[0]).to eq(1)
    end

    it 'returns the player to the starting square when they have moved 12 places' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(6)

      places = game.places
      player_1 = 0
      expect(places[player_1]).to eq(0)
    end

    it 'does not change who the current player is' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      player_1 = 0
      expect { game.roll(rand(1..6)) }.not_to change(game, :current_player).from(player_1)
    end

    example 'a player can cycle around the board multiple times, every 12 places' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      3.times do
        game.roll(6)
        game.roll(6)
      end

      places = game.places
      player_1 = 0
      expect(places[player_1]).to eq(0)
    end

    {
      1 => 'Science',
      2 => 'Sports',
      3 => 'Rock',
      4 => 'Pop'
    }.each do |number, category|
      it 'asks the player a question from the appropriate category' do
        game = UglyTrivia::GameWithCommentary.with(['Player 1', 'Player 2'])

        game.roll(number)

        expect(game.commentary).to include("The category is #{category}")
        expect(game.commentary).to include("#{category} Question 0")
      end
    end

    example 'after a question is asked, it is places at the bottom of the pack for its category'
  end

  it "consists of 50 Science questions" do
    game = game_without_commentary_involving(['Player 1', 'Player 2'])

    questions = game.science_questions
    expected_questions = (0..49).map {|number| "Science Question #{number}"}
    expect(questions).to eq(expected_questions)
  end

  describe 'A player is asked science questions when:' do
    example 'they have moved one place from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(1)

      category = current_category(game)
      expect(category).to eq('Science')
    end

    example 'they have moved 5 spaces forwards from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(5)

      category = current_category(game)
      expect(category).to eq('Science')
    end

    it 'they have moved 9 spaces forwards from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(3)
      game.roll(6)

      category = current_category(game)
      expect(category).to eq('Science')
    end
  end

  it "consists of 50 Pop questions" do
    game = game_without_commentary_involving(['Player 1', 'Player 2'])

    questions = game.pop_questions
    expected_questions = (0..49).map {|number| "Pop Question #{number}"}
    expect(questions).to eq(expected_questions)
  end

  describe 'A player is asked pop questions when:' do
    example 'they are at the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      category = current_category(game)
      expect(category).to eq('Pop')
    end

    example 'they have moved 4 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(4)

      category = current_category(game)
      expect(category).to eq('Pop')
    end

    example 'they have moved 8 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(4)
      game.roll(4)

      category = current_category(game)
      expect(category).to eq('Pop')
    end
  end

  it 'consists of 50 Sports questions' do
    game = game_without_commentary_involving(['Player 1', 'Player 2'])

    questions = game.sports_questions
    expected_questions = (0..49).map {|number| "Sports Question #{number}"}
    expect(questions).to eq(expected_questions)
  end

  describe 'A player is asked a sports question when:' do
    example 'they have moved 2 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(2)

      category = current_category(game)
      expect(category).to eq('Sports')
    end

    example 'they have moved 6 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(6)

      category = current_category(game)
      expect(category).to eq('Sports')
    end

    example 'they have moved 10 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(4)

      category = current_category(game)
      expect(category).to eq('Sports')
    end
  end

  it 'consists of 50 Rock questions' do
    game = game_without_commentary_involving(['Player 1', 'Player 2'])

    questions = game.rock_questions
    expected_questions = (0..49).map {|number| "Rock Question #{number}"}
    expect(questions).to eq(expected_questions)
  end

  describe 'A player is asked a rock question when:' do
    example 'when they have moved 3 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(3)

      category = current_category(game)
      expect(category).to eq('Rock')
    end
    example 'when they have moved 7 places from the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(5)
      game.roll(2)

      category = current_category(game)
      expect(category).to eq('Rock')
    end

    example 'when they have moved 11 places from the the start' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(5)

      category = current_category(game)
      expect(category).to eq('Rock')
    end
  end

  context 'Given the player answers their question correctly' do
    let(:game) { game_without_commentary_involving(['Player 1', 'Player 2']) }
    before do
      game.roll(1)
      game.was_correctly_answered
    end

    it 'awards that player a gold coin' do
      purses = game.purses
      player_1 = 0
      expect(purses[player_1]).to eq(1)
    end

    it "is the next players turn's" do
      current_player = game.current_player
      player_2 = 1
      expect(current_player).to eq(player_2)
    end

  end

  context 'when the last player has their turn' do
    example 'the game returns to the very first player' do
      game = game_without_commentary_involving(['Player 1', 'Player 2'])

      game.roll(1)
      game.was_correctly_answered

      # player 2's turn
      game.roll(3)
      game.was_correctly_answered

      current_player = game.current_player
      player_1 = 0
      expect(current_player).to eq(player_1)
    end
  end

  context 'Given the player answers their question incorrectly' do
    let(:game) { game_without_commentary_involving(['Player 1', 'Player 2']) }
    before do
      game.roll(2)
      game.wrong_answer
    end

    it 'places the player in the penalty box' do
      player_1 = 0
      player_in_penalty_box = game.in_penalty_box[player_1]
      expect(player_in_penalty_box).to eq(true)
    end

    it "is the next player's turn" do
      current_player = game.current_player
      player_2 = 1
      expect(current_player).to eq(player_2)
    end

    context 'when the player rolls an odd number' do
      it 'allows them to get out of the penalty box when they answer the question correctly' do
        # player 2's turn
        game.roll(2)
        game.was_correctly_answered

        # player 1's turn
        game.roll(3)
        game.was_correctly_answered

        player_out_of_penalty_box = game.is_getting_out_of_penalty_box
        expect(player_out_of_penalty_box).to eq(true)
      end

      it 'allows them to get out of the penalty box when they answer the question incorrectly' do
        # player 2's turn
        game.roll(1)
        game.was_correctly_answered

        # player 1's turn
        game.roll(5)
        game.wrong_answer

        player_out_of_penalty_box = game.is_getting_out_of_penalty_box
        expect(player_out_of_penalty_box).to eq(true)
      end
    end

    it 'keeps the player in the penalty box when that player rolls an even number' do
      game.roll(1)
      game.was_correctly_answered

      # player 1's turn
      game.roll(4)
      game.wrong_answer

      player_out_of_penalty_box = game.is_getting_out_of_penalty_box
      expect(player_out_of_penalty_box).to eq(false)
    end

  end

  example 'the first player to have 6 gold coins is declared the winner'
end