class UsersController < ApplicationController
    register Sinatra::Flash
    require 'sinatra/flash'
    enable :sessions

    get '/login' do
      @error_message = params[:error]
      if !logged_in?
        erb :'/users/login'
      else
        redirect("/project")
      end
    end
      
    get '/signup' do
        @error_message = params[:error]
        if !logged_in?
            erb :'/users/signup'
        else
            redirect("/project")
        end
    end
      
    get '/logout' do
        if logged_in?
            session.clear
            redirect("/login")
        else
            redirect("/login")
        end
    end
      
    get '/users' do
      @users = User.all
      erb :'/users/index'
    end
      
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end
      
    post '/signup' do
        if !User.all.find_by(username: params[:username])
          if !params[:username].blank? && !params[:password].blank?
             @user = User.create(username: params[:username], password: params[:password])
             @user.save
             session[:user_id] = @user.id
             redirect("/project")
           else
             redirect("/signup")
           end
         else
           redirect("/signup?error=This username already exists.")
        end
    end
      
    post '/login' do
        @user = User.find_by(username: params[:username])
          if @user != nil && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect("/project")
          else
            redirect("/signup")
        end
    end

    
    
end
      
