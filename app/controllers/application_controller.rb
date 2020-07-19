require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "thesecret"
  end

  get '/' do
    if logged_in?
        @user = current_user
        erb :'index'
    else
        erb :'index'
    end
  end

  helpers do

        def current_user
            if session[:user_id]
                @current_user ||= User.find(session[:user_id])
            end
        end

        def logged_in?
            !!current_user
        end

        #"match operator" and can be used to match a string against a regular expression.
        def validate_user(username) #returns 0 if true, #returns nil otherwise, so made this using a boolean operator
            (username =~ /\A[a-z0-9_]{4,16}\Z/) == 0
        end

    end


end