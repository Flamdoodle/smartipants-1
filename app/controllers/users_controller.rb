class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Unable to create user."
      redirect_to root_path
    end
  end

def profile
  if session[:user_id]
    spline_graph_brain = SplineGraphBrain.new(session[:user_id])
    @color_correct = spline_graph_brain.color_correct
    @audio_correct = spline_graph_brain.audio_correct
    @position_correct = spline_graph_brain.position_correct
    @total_correct = spline_graph_brain.total_correct
    @games = spline_graph_brain.game_dates
    @username = User.find(session[:user_id]).username
  else
    redirect_to root_path
  end
end

  def data
    spline_graph_brain = SplineGraphBrain.new(session[:user_id])
    render json: {games: spline_graph_brain.game_dates,
         color_correct: spline_graph_brain.color_correct,
         audio_correct: spline_graph_brain.audio_correct,
         position_correct: spline_graph_brain.position_correct,
         total_correct: spline_graph_brain.total_correct,
         n: spline_graph_brain.n,
         positions_true: PositionGraphBrain.position_true(session[:user_id]),
         colors_true: ColorGraphBrain.color_true(session[:user_id]),
         audios_true: AudioGraphBrain.audio_true(session[:user_id]),
         user_object: User.find(session[:user_id])}.to_json
  end

  def login
    @user = User.find_and_auth(user_params[:email], user_params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Unable to log in."
      redirect_to root_path
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def update
    @user = User.find(session[:user_id])
    @user.update_attributes(user_params)
    flash[:error] = "Unable to update your info." unless @user.save
    redirect_to root_path
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.update_attributes(user_params)
    @user.save(validate: false)
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
