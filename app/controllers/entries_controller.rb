class EntriesController < ApplicationController

    get '/entries' do
        if logged_in?
          @user = current_user
          @entries = Entry.all
          erb :'/entries/entries'
        else
          redirect to "/login"
        end
      end
    
      get '/tweets/new' do
        if logged_in?
          @user = current_user
          erb :'tweets/new'
        else
          redirect "/login"
        end
      end

end