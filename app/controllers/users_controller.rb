class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "thesecret"
      end

      get '/signup' do
        if !logged_in? #if not logged in
            erb :'signup'
        else #if logged in
            @user == current_user
            redirect to '/entries'
        end
     end

     post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/error' #error.erb aka Please enter a valid username, email and password.
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user_id
            redirect to '/entries' #Maybe a welcome page, actually
        end
    end

    


    
end