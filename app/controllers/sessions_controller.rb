class SessionsController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "thesecret"
      end
    
    get '/login' do
        if !logged_in? #if not logged in
            erb :'users/login'
        else
            redirect to '/entries'
        end
     end

      post '/login' do
        # @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])     #if @user exists
            session[:user_id] = @user.id #id is sessions
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