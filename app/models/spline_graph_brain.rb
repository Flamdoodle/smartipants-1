class SplineGraphBrain
  def initialize(player)
    @player = player
  end

  def user
    @user = @player
  end

  def game_dates
    @user = User.find(@player)
    @games = @user.games.all
    @game_dates = []
    @games.each do |game|
      @game_dates << game.created_at.strftime('%d %b')
    end
    @game_dates
  end

  def color_correct
    @color_answer = []
    @color_id = []
    User.find(@player).games.all.each do |game|
      color_answer = []
      color_id = []
      game.rounds.each do |round|
        color_answer << round.color_correct
        color_id << round.color_id
      end
      @color_answer << color_answer
      @color_id << color_id
    end
    @answer3 = []
    @color_answer.each do |answer|
      response1 = []
      answer.each do |bool|
        if bool == true
          response1 << bool
        end
      end
      @answer3 << response1.length
    end
    @answer3
  end

  def audio_correct
    @audio_answer = []
    @audio_id = []
    @game_n = []
    User.find(@player).games.all.each do |game|
      audio_answer = []
      audio_id = []
      @game_n << game.n
      game.rounds.each do |round|
        audio_answer << round.audio_correct
        audio_id << round.audio_id
      end
      @audio_answer << audio_answer
      @audio_id << audio_id
    end
    @answer4 = []
    @audio_answer.each do |answer|
      response = []
      answer.each do |bool|
        if bool == true
          response << bool
        end
      end
      @answer4 << response.length
    end

    @game_n = @game_n.zip(@answer4).flatten.compact
    @game_n = @game_n.each_slice(2).to_a
    @answer4
    @game_n
  end

  def position_correct
    @position_answer = []
    @position_id = []
    User.find(@player).games.all.each do |game|
      position_answer = []
      position_id = []
      game.rounds.each do |round|
        position_answer << round.position_correct
        position_id << round.position
      end
      @position_answer << position_answer
      @position_id << position_id
    end
    @answer6 = []
    @position_answer.each do |answer|
      response = []
      answer.each do |bool|
        if bool == true
          response << bool
        end
      end
      @answer6 << response.length
    end
    @answer6
  end

  def total_correct
    @game_type = []
    @user = User.find(@player)
    @game = @user.games.last
    @answer6.each_with_index do |answer, ind|
      if @answer3[ind]==0 && @answer4[ind]==0
        @game_type << 1
      elsif @answer3[ind]==0
        @game_type << 2
      else
        @game_type << 3
      end
    end
    @total_correct = [@answer3,@answer4].transpose.map {|x| x.reduce(:+)}
    @total_correct = [@total_correct,@answer6].transpose.map {|x| x.reduce(:+)}
    @full_total = @game_type.zip(@total_correct).flatten.compact
    @full_total = @full_total.each_slice(2).to_a
    @full_total
  end


  def n
    @user = User.find(@player)
    @game = @user.games.last
    @n = @game.n
  end

end
