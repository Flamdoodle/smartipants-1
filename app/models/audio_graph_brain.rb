class AudioGraphBrain
  def initialize(player)
    @player = player
  end

  def user
    @user = @player
  end

  def audio_true
    @audio_true_array = []
    @user = User.find(@player)
    @game = @user.games.last
    @true_rounds = @game.rounds.where(audio_correct: true)
    @true_rounds.each do |round|
      @audio_true_array << round.audio_id
    end
    @audio_hash = Hash.new(0)
    @audio_true_array.each { | v | @audio_hash.store(v, @audio_hash[v]+1) }
    @audio_hash
  end

end
