class ColorGraphBrain
  def initialize(player)
    @player = player
  end

  def color_true
    @color_true_array = []
    @user = User.find(@player)
    @game = @user.games.last
    @true_rounds = @game.rounds.where(color_correct: true)
    @true_rounds.each do |round|
      @color_true_array << round.color_id
    end
    @color_true_array
    @color_hash = Hash.new(0)
    @color_true_array.each { | v | @color_hash.store(v, @color_hash[v]+1) }
    @color_hash
  end

end
