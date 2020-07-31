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
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            if @user.save
              session[:user_id] = @user.id
              redirect to '/entries'
            else
              flash[:error] = @user.errors.full_messages.join(". ")
              redirect to '/signup'
            end
      end

      get '/edit_user' do
        erb :edit
      end

      patch '/edit_user' do
        @user = User.find_by(username: params[username])
              if logged_in?
                  @user = current_user
                    if @user.valid?
                        @user.update(username: params[:username], email: params[:email], password: params[:password])
                        @user.save
                        redirect to "/entries"
                    else
                        flash[:error] = @user.errors.full_messages.join(". ")
                        redirect to "/edit_user"
                    end
              else
                redirect to '/'
              end
        end




end