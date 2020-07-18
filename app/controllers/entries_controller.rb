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
    
      get '/entries/new' do
        if logged_in? #if logged in
          @user = current_user
          erb :'entries/new'
        else
          redirect "/" #if not, go to index to sign up or log in
        end
      end

    
      post '/entries' do #after user makes a new entry
        @entry = Entry.new(params)
        @user = current_user
        if logged_in? && @entry.content != "" && @entry.save
            @user.entries << @entry
            redirect to "/entries/#{@entry.id}"
        else
            redirect "/entries/new"  
        end
      end



end