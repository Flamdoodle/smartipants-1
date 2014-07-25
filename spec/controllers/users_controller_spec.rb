require 'spec_helper'

describe UsersController do

  context '#create' do

    describe 'valid info' do
      before :each do
        post :create, :user => {"username" => "test_user", "email" => "test@email.test", "password" => "test", "password_confirmation" => "test"}
      end

      it 'is a valid route' do
        expect(response.status).to eq 302
      end

      it 'adds a valid user to the database' do
        expect(assigns(:user)).to be_an_instance_of User
      end
    end

    describe 'invalid info' do
      before :each do
        post :create, :user => {"username" => "test_invalid_user", "email" => "test@invalidtest", "password" => "test", "password_confirmation" => "test"}
      end

      it 'sets an error message if the user is invalid' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  context '#login' do
    describe 'valid user info' do
      before :each do
        user = User.create(email: 'test@test.com', password_confirmation: 'test', password: 'test')
        get :login, :user => {'email' => 'test@test.com', 'password' => 'test' }
      end
      it 'is a valid route' do
        expect(response.status).to eq 302
      end

      it 'assigns a user when given valid params' do
        expect(assigns(:user)).to be_an_instance_of User
      end
      it 'will set a session id' do
        expect(session[:user_id]).to_not be_nil
      end
    end

    describe 'invalid user info' do
      before :each do
        get :login, :user => {'email' => 'nouserhas@this.email', 'password' => 'notapassword' }
      end
      it 'does not assign a user, given invalid params' do
        expect(assigns(:user)).to be_nil
      end
      it 'will not set a session id' do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  context '#show' do
    it 'is a valid route' do
      expect(response.status).to eq 200
    end
  end

  context '#logout' do
    before :each do
      session[:user_id] = 5
      get :logout
    end
    it 'is a valid route' do
      expect(response.status).to eq 302
    end

    it 'clears the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end

  context '#update' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    describe 'for valid user input' do
      it 'locates the correct user' do
        patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq @user
      end

      it 'updates the users attributes' do
        patch :update, id: @user, user: FactoryGirl.attributes_for(:user, username: 'newusername', email: 'newemail@test.com')
        @user.reload
        expect(@user.username).to eq 'newusername'
        expect(@user.email).to eq 'newemail@test.com'
      end

      it 'redirects to root path' do
        patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    describe 'for invalid user input' do
      it 'does not update the users attributes' do
        patch :update, id: @user, user: FactoryGirl.attributes_for(:user, email: '@#$%^%##')
        @user.reload
        expect(@user.email).to_not eq '@#$%^%##'
      end

      it 'creates a flash notification' do
        patch :update, id: @user, user: FactoryGirl.attributes_for(:user, email: '@#$%^%##')
        expect(flash[:error]).to eq "Unable to update your info."
      end
    end
  end

  context '#destroy' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it 'locates the correct user' do
      delete :destroy, id: @user, user: FactoryGirl.attributes_for(:user)
      expect(assigns(:user)).to eq @user
    end

    it 'updates identifying info to anonymous info' do
      delete :destroy, id: @user, user: FactoryGirl.attributes_for(:user, username: 'anonymous', email: 'anonymous@anonymous.anonymous')
      @user.reload
      expect(@user.username).to eq "anonymous"
      expect(@user.email).to eq "anonymous@anonymous.anonymous"
    end

    it 'clears the session' do
      delete :destroy, id: @user, user: FactoryGirl.attributes_for(:user)
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      delete :destroy, id: @user, user: FactoryGirl.attributes_for(:user)
      expect(response).to redirect_to root_path
    end
  end

  context '#profile' do
    it 'is a valid route' do
      expect(response.status).to eq 200
    end
  end

  context '#data' do
    it 'is a valid route' do
      expect(response.status).to eq 200
    end
  end
end
