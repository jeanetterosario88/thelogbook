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
        redirect "/" #if not, sign up or log in
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
            if @entry && @entry.user == @user
              erb :'/entries/show'
            else
              erb :'/entries/entries'
            end
      else
        redirect to "/login"
      end
    end
  
    get '/entries/edit/:id' do
      if logged_in?
          @user = current_user
          @entry = Entry.find(params[:id])
          if @user.entries.include?(@entry)
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
          if logged_in?
            @user = current_user
            if !params[:content].blank? || !params[:contact].blank? || !params[:rating].blank? #if one of these is not blank, aka filled out
              @entry.update(category: params[:category], date: params[:date], rating: params[:rating], content: params[:content], contact: params[:contact])
              @entry.save
              redirect to "/entries/#{@entry.id}"
          else
              redirect to "/entries/edit/#{@entry.id}"
          end
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

     

end