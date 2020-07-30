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
        if !validate_user(params[:username]) || params[:email] == "" || params[:password] == "" || User.all.find_by(:username => params[:username])
          redirect to 'users/error'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user.id
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

            #"match operator" and can be used to match a string against a regular expression.
        #  def validate_user(username) #returns 0 if true, #returns nil otherwise, so made this using a boolean operator
        #      (username =~ /\A[a-z0-9_]{4,16}\Z/) == 0
        #  end

         get '/users/error' do
            erb :'users/error'
         end


end