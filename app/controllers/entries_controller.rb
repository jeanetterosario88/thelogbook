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
        @entry = Entry.create(params)
        @user = current_user
        if logged_in? && @entry.content != "" && @entry.save
            @user.entries << @entry
            redirect to "/entries/#{@entry.id}"
        else
            redirect "/entries/new"  
        end
      end

      get "/entries/:id" do
        if logged_in?
          @user = current_user
          @entry = Entry.find_by_id(params[:id])
          erb :'/entries/show'
        else
          redirect to "/login"
        end
      end
    
      get '/entries/edit/:id' do
        if logged_in?
            @user = current_user
            @entry = Entry.find(params[:id])
            if @user.entries.include?(@entry)
                #@entry.user == @user
            erb :'entries/edit'
            else
                redirect to '/entries'
            end
        else
            redirect to '/login'
            end
        end
    
      patch "/entries/:id" do
        @entry = Entry.find(params[:id])
            if logged_in? && (!params[:content].blank? || !params[:contact].blank? || !params[:rating].blank?) #if one of these is not blank, aka filled out
                @entry.update(category: params[:category], date: params[:date], rating: params[:rating], content: params[:content], contact: params[:contact])
                @entry.save
                redirect to "/entries/#{@entry.id}"
            else
                redirect to "/entries/#{@entry.id}/edit"
            end
        end

        get "/entries/delete/:id" do
         if logged_in?
             @entry = Entry.find(params[:id])
             if @entry && @entry.user == current_user
                    @entry.delete
                    redirect to '/entries'
            end
            else
                redirect to '/login'
            end 
        end
 
        def validate_user(username) #returns 0 if true, #returns nil otherwise, so made this using a boolean operator
          (username =~ /\A[a-z0-9_]{4,16}\Z/) == 0
        end

end