class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "thesecret"
      end

      get '/signup' do
        if !logged_in? #if not logged in
            erb :'users/signup'
        else #if logged in
            @user == current_user
            redirect to '/entries'
        end
     end

     post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/error' #error.erb aka Please fill out enter form.
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user_id
            redirect to '/entries'
      end
    end

    get '/login' do
        if !logged_in? #if not logged in
            erb :'users/login'
        else
            redirect to '/entries'
      end
     end

      post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/entries'
          else
            redirect to 'users/error'
          end
        end

        post '/logout' do
            if !logged_in?
              redirect to '/'
            else
              session.clear
              redirect to "/login"
            end
          end


    
end