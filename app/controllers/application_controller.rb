require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "thesecret"
    register Sinatra::Flash
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

    end


end