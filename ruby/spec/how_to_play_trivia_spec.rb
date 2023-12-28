require 'spec_helper'
require_relative '../lib/ugly_trivia/game'
require_relative './game_with_commentary'
require_relative './game_with_no_commentary'

describe "How to play Trivia" do
  describe 'How many players can play trivia' do
    it 'is not a 1-player game' do
      game = silent_game_involving(['Player 1'])

      expect(game.is_playable?).to eq(false)
    end

    it 'requires a minimum of 2 players' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by exactly 6 players' do
      players = (1..6).map {|number| "Player #{number}"}
      game = silent_game_involving(players)

      expect(game.is_playable?).to eq(true)
    end

    it 'can be played by more than 6 players' do
      players = (1..7).map {|number| "Player #{number}"}
      game = silent_game_involving(players)

      expect(game.is_playable?).to eq(true)
    end

    context 'Trivia game involving three players' do
      example 'all players start at the beginning' do
        game = silent_game_involving(['Player 1', 'Player 2', 'Player 3'])

        expect(game.places).to all(eq(0))
      end

      example 'all players start with no coins in their purse' do
        game = silent_game_involving(['Player 1', 'Player 2', 'Player 3'])

        expect(game.purses).to all(eq(0))
      end

      it 'has no one in the penalty box at the beginning' do
        game = silent_game_involving(['Player 1', 'Player 2', 'Player 3'])

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
        game = silent_game_involving(players)

        expect(game.in_penalty_box[1..-1]).to all eq(false)
        expect(game.in_penalty_box.first).to be_nil
      end
    end

    it 'reports the player who is playing and what player number they are' do
      game = game_with_commentary_involving(['Khushboo'])

      expect(game.commentary).to include('Khushboo was added')
      expect(game.commentary).to include(match(/They are player number \d/))
    end
  end

  describe 'Rolling the die' do
    it 'does not advance a player when they roll a 0'

    it 'reports who is the current player' do
      game = game_with_commentary_involving(['Player 1', 'Player 2'])

      game.roll(6)

      expect(game.commentary).to include(match(/Player \d is the current player/))
    end

    it 'reports the number the current player rolled' do
      game = game_with_commentary_involving(['Player 1', 'Player 2'])

      game.roll(4)

      expect(game.commentary).to include('They have rolled a 4')
    end

    it 'advances a player a number of places as shown on the die' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      player_1 = 0
      expect { game.roll(1) }.to change { game.places[player_1] }.by(1)
    end

    it "reports the player's current place on the board" do
      game = game_with_commentary_involving(['Player 1', 'Player 2'])

      game.roll(5)

      expect(game.commentary).to include("Player 1's new location is 5")
    end

    it 'does not change who the current player is' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      player_1 = 0
      expect { game.roll(rand(1..6)) }.not_to change(game, :current_player).from(player_1)
    end

    it 'moves player to the penultimate square before go' do
      game = silent_game_involving(['Player 1', 'Player 2'])
      # player 1's turn
      # player 1's turn. They have moved 2, 3, 3 and 3 places. At the 12th space, they cycle back to go, advancing 1.
      [2, 3, 3, 3].each { |number| game.roll(number) }

      player_1 = 0
      expect(game.places[player_1]).to eq(11)
    end

    it 'returns the player to the starting square when they have moved 12 places' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(5)

      player_1 = 0
      expect { game.roll(1) }. to change { game.places[player_1] }.from(11).to(0)
    end

    it 'moves the player to the next square from the start when they have moved more than 12 places' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      game.roll(6)
      game.roll(5)

      player_1 = 0
      expect { game.roll(3) }. to change { game.places[player_1] }.from(11).to(2)
    end

    example 'a player can cycle around the board multiple times, every 12 places' do
      game = silent_game_involving(['Player 1', 'Player 2'])

      3.times do
        game.roll(6)
        game.roll(6)
      end

      player_1 = 0
      expect(game.places[player_1]).to eq(0)
    end

    {
      1 => 'Science',
      2 => 'Sports',
      3 => 'Rock',
      4 => 'Pop'
    }.each do |number, category|
      it "reports the current category of question that will be asked e.g. #{category} when #{number} is rolled" do
        game = game_with_commentary_involving(['Player 1', 'Player 2'])

        game.roll(number)

        expect(game.commentary).to include("The category is #{category}")
      end

      it "asks the player a #{category} question when #{number} is rolled" do
        game = game_with_commentary_involving(['Player 1', 'Player 2'])

        game.roll(number)

        expect(game.commentary).to include("#{category} Question 0")
      end
    end
  end

  context 'When the player answers their question correctly' do
    let(:game_with_commentary) { game_with_commentary_involving(['Player 1', 'Player 2']) }

    it 'announces that the answer is correct' do
      # Player 1's turn
      game_with_commentary.roll(1)
      game_with_commentary.was_correctly_answered

      # spelling error - correct rather than corrent
      expect(game_with_commentary.commentary).to include('Answer was correct!!!!')
    end

    it 'awards that player a gold coin' do
      # Player 1's turn
      game_with_commentary.roll(1)
      game_with_commentary.was_correctly_answered

      player_1 = 0
      expect(game_with_commentary.purses[player_1]).to eq(1)
      expect(game_with_commentary.commentary).to include('Player 1 now has 1 Gold Coins.')
    end

    it 'declares no winner when either player has fewer than six gold coins' do
      # Player 1's turn
      game_with_commentary.roll(1)
      no_winner = game_with_commentary.was_correctly_answered

      expect(no_winner).to eq(true)
    end

    it "is the next players turn's" do
      # Player 1's turn
      game_with_commentary.roll(1)
      game_with_commentary.was_correctly_answered

      player_2 = 1
      expect(game_with_commentary.current_player).to eq(player_2)
    end

    context 'When the last player has their turn' do
      example 'the game returns to the very first player' do
        # Player 1's turn
        game_with_commentary.roll(1)
        game_with_commentary.was_correctly_answered

        # player 2's turn
        game_with_commentary.roll(3)
        game_with_commentary.was_correctly_answered

        player_1 = 0
        expect(game_with_commentary.current_player).to eq(player_1)
      end
    end
  end

  context 'When the player answers their question incorrectly' do
    let(:game) { game_with_commentary_involving(['Player 1', 'Player 2']) }

    before do
      game.roll(2)
      game.wrong_answer
    end

    it 'announces that the answer is incorrect' do
      expect(game.commentary).to include('Question was incorrectly answered')
    end

    it 'places the player in the penalty box' do
      player_1 = 0
      expect(game.commentary).to include('Player 1 was sent to the penalty box')
      expect(game.in_penalty_box[player_1]).to eq(true)
    end

    it "is the next player's turn" do
      current_player = game.current_player
      player_2 = 1
      expect(current_player).to eq(player_2)
    end

    it "cycle's back player one's turn when the last player has had their go" do
      game.roll(3)
      game.wrong_answer

      first_player = 0
      expect(game.current_player).to eq(first_player)
    end

    context 'Given a player is in the penalty box' do
      context 'when the player rolls an odd number' do
        before do
          # player 2's turn
          game.roll(2)
          game.was_correctly_answered

          # player 1's turn
          game.roll(3)
        end

        it 'allows them to advance a number of spaces' do
          player_1 = 0
          expect(game.places[player_1]).to eq(2 + 3)
        end

        it "reports the player's current place on the board" do
          expect(game.commentary).to include("Player 1's new location is 5")
        end

        it 'asks a question from the category applicable to the place' do
          expect(game.commentary).to include('The category is Science','Science Question 0')
        end

        it 'moves player to the penultimate square before go' do
          # player 1's turn
          game.wrong_answer

          # player 2's turn
          game.roll(1)
          game.was_correctly_answered

          # player 1's turn. They have moved 2, 3, 3 and 3 places. At the 12th space, they cycle back to go, advancing 1.
          game.roll(3)
          game.roll(3)

          player_1 = 0
          expect(game.places[player_1]).to eq(11)
        end

        it 'allows current player back to square one after they move 12 places' do
          # player 1's turn
          game.wrong_answer

          # player 2's turn
          game.roll(1)
          game.was_correctly_answered

          # player 1's turn. They have moved 2, 3, 5 and 3 places. At the 12th space, they cycle back to go, advancing 1.
          game.roll(5)
          game.roll(3)

          player_1 = 0
          expect(game.places[player_1]).to eq(1)
        end

        it 'allows them to get out of the penalty box when they answer the question correctly' do
          # player 1's turn
          game.was_correctly_answered

          player_out_of_penalty_box = game.is_getting_out_of_penalty_box
          expect(player_out_of_penalty_box).to eq(true)
        end

        it 'takes them out of the penalty box when they are answer the question correctly' do
          pending('To discuss with domain expert')
          game.was_correctly_answered

          in_penalty_box = game.in_penalty_box
          player_1 = 0
          expect(in_penalty_box[player_1]).to eq(false)
        end

        it 'still allows them to get out of the penalty box even after they answer the question incorrectly' do
          # player 1's turn
          game.wrong_answer

          player_out_of_penalty_box = game.is_getting_out_of_penalty_box
          expect(player_out_of_penalty_box).to eq(true)
        end
      end

      context 'when the player rolls an even number' do
        before do
          # Player 2's turn
          game.roll(2)
          game.was_correctly_answered
        end

        it 'keeps the player in the penalty box' do
          # player 1's turn
          game.roll(4)
          game.wrong_answer

          player_out_of_penalty_box = game.is_getting_out_of_penalty_box
          expect(player_out_of_penalty_box).to eq(false)
        end

        it 'reports that the player is not leaving the penalty box' do
          # player 1's turn
          game.roll(6)
          game.wrong_answer

          expect(game.commentary).to include('Player 1 is not getting out of the penalty box')
        end

        it 'does not ask the player a question'
      end

      context 'and they qualify to leave it' do
        it "is the next player's turn" do
          # player 2's turn
          game.roll(2)
          game.was_correctly_answered

          # player 1's turn again and they roll an odd number, meaning they
          # qualify to leave the penalty box
          game.roll(3)
          game.was_correctly_answered

          player_2 = 1
          expect(game.current_player).to eq(player_2)
        end

        it 'announces that the question was answered correctly' do
          game.roll(1)
          game.was_correctly_answered

          # player 1's turn again and they roll an odd number, meaning they
          # qualify to leave the penalty box
          game.roll(1)
          game.was_correctly_answered
          expect(game.commentary).to include('Answer was correct!!!!')
        end

        it "awards then a coin when they answer the question correctly" do
          # player 2's turn
          game.roll(2)
          game.was_correctly_answered

          # player 1's turn again and they roll an odd number, meaning they
          # qualify to leave the penalty box
          game.roll(3)
          game.was_correctly_answered

          player_1 = 0
          expect(game.purses[player_1]).to eq(1)
          expect(game.commentary).to include('Player 1 now has 1 Gold Coins.')
        end

        context 'Given the last player is also in the penalty box' do
          before do
            game.roll(3)
            game.wrong_answer
            # player 2 is now in the penalty box
          end

          it 'cycles back to the first player' do
            # player 1's turn
            game.roll(3)
            game.was_correctly_answered
            # player 1 is now getting out of the penalty box

            # player 2's turn
            game.roll(5)
            game.was_correctly_answered
            # player 2 is now getting out of the penalty box

            player_1 = 0
            expect(game.current_player).to eq(player_1)
          end
        end
      end

      context 'and they do not qualify to leave it' do
        it "is the next player's turn" do
          game.roll(2) # Player 2's turn
          game.was_correctly_answered

          # Player 1's turn. As they roll an even number, they do not qualify to leave
          # the penalty box
          game.roll(2)
          game.was_correctly_answered

          player_2 = 1
          expect(game.current_player).to eq(player_2)
        end

        it "cycles back to the first player when the last player has had their turn" do
          game.roll(4) # player 2's turn
          game.was_correctly_answered

          game.roll(2) # player 1's turn
          game.was_correctly_answered

          game.roll(4) # player 2's turn
          game.was_correctly_answered

          player_1 = 0
          expect(game.current_player).to eq(player_1)
        end

        it 'does not award the player a gold coin when they answer the question correctly' do
          game.roll(4) # player 2's turn
          game.was_correctly_answered

          # Player 1's turn again and they roll an even number. They do not qualify, then,
          # to leave the penalty box even when they answer the question correctly.
          game.roll(4)

          player_1 = 0
          expect { game.was_correctly_answered }.not_to change { game.purses[player_1] }
        end
      end
    end
  end

  example 'the first player to have 6 gold coins is declared the winner' do
    game = game_with_commentary_involving(['Player 1', 'Player 2'])

    5.times do
      game.roll(3)
      game.was_correctly_answered
      game.roll(1)
      game.wrong_answer
    end

    game.roll(6)
    no_winner = game.was_correctly_answered

    player_1 = 0
    expect(game.purses[player_1]).to eq(6)
    expect(no_winner).to eq(false)
  end

  private

  def silent_game_involving(players)
    UglyTrivia::GameWithNoCommentary.with(players)
  end

  def game_with_commentary_involving(players)
    UglyTrivia::GameWithCommentary.with(players)
  end
end