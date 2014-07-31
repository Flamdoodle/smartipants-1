class PositionGraphBrain
  def initialize(player)
    @player = player
  end

  def position_true
    @position_true_array = []
    @user = User.find(@player)
    @game = @user.games.last
    @true_rounds = @game.rounds.where(position_correct: true)
    @true_rounds.each do |round|
      @position_true_array << round.position
    end
    @position_true_array
    @position_hash = Hash.new(0)
    @position_true_array.each { | v | @position_hash.store(v, @position_hash[v]+1) }
    @position_hash
  end

end
