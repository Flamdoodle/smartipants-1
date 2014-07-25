require 'spec_helper'


valid_game = {
  n: 2,
  rounds: [
    {
        roundNumber: 1,
        colorId: 1,
        audioId: 1,
        position: 1,
        colorGuess: true,
        audioGuess: false,
        positionGuess: true
    },
    {
        roundNumber: 3,
        position: 1,
        colorId: 2,
        audioId: 4,
        colorGuess: false,
        audioGuess: false,
        positionGuess: false
    },
    {
        roundNumber: 2,
        colorId: 4,
        audioId: 2,
        position: 3,
        colorGuess: true,
        audioGuess: true,
        positionGuess: true
    },
    {
        roundNumber: 4,
        colorId: 1,
        audioId: 1,
        position: 2,
        colorGuess: true,
        audioGuess: false,
        positionGuess: false
    }
  ]
}

invalid_game = {
  n: nil,
  rounds: [
    {
        color_id: 1,
        audio_id: 1,
        color_correct: true,
        audio_correct: false
    }
  ]
}


describe GameBuilder do
  user_id = 1
  game_builder_valid = GameBuilder.new(user_id, valid_game)
  game_builder_invalid = GameBuilder.new(user_id, invalid_game)

  context 'on #create_game' do
    it 'saves a valid game to the database' do
      expect(game_builder_valid.create_game).to eq true
    end
    it 'doesn\'t save an invalid game' do
      expect(game_builder_invalid.create_game).to eq false
    end
  end

end
