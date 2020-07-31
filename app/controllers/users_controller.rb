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
        # if !validate_user(params[:username]) || params[:email] == "" || params[:password] == "" || User.all.find_by(:username => params[:username])
        #   redirect to 'users/error'
        # else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            if @user.save
              session[:user_id] = @user.id
              redirect to '/entries'
            else
              flash[:error] = @user.errors.full_messages.join(". ")
              redirect to '/signup'
            end
    end

    #get edit
    #patch edit


end