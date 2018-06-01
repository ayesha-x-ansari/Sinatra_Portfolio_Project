class UsersController < ApplicationController

  get '/reset' do
    erb :'users/reset'
  end

  post '/reset' do
    "ddddddd"
    if params[:email] == "" || params[:password] == ""
        flash[:message] = "All fields should be filled"
        redirect to '/reset'
    end
      user = User.find_by_email(params[:email])
      user.password = params[:password]
      user.save
  #    erb :show

    #  user = User.find_by(:email => params[:email])
    #  if !user.nil?
    #   @user = User.update(:password => params[:password])
    #   session[:user_id] = @user.id
    #   redirect("/login")
    #   end
    end

  get '/users/:id' do
    if !logged_in?
      redirect '/bags'
    end

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/bags'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/clubs'
    end
  end

  post '/signup' do

    if params[:name] == "" || params[:email] == ""  || params[:username] == "" || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect to '/signup'
    end

    user = User.find_by(:username => params[:username])
    if !user.nil?
      flash[:message] = "A account already exists with this username"
      redirect("/signup")
    end

    user = User.find_by(:email => params[:email])
    if !user.nil?
      flash[:message] = "A account already exists with this email address"
      redirect("/signup")
    end

    if params[:password].size < 5
      flash[:message] = "Password cannot be less than 8 characters"
      redirect("/signup")
    end

    @user = User.create(:name => params[:name], :email => params[:email], :username => params[:username], :password => params[:password])
    session[:user_id] = @user.id
    redirect '/login'
  end



  get '/login' do
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      erb :'users/login'
    #  redirect '/bags'
    end
  end


  post '/login' do
    if params[:email] == ""  || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect to '/login'
    end

    user = User.find_by(:email => params[:email])
    if user.nil?
      flash[:message] = "Can't find your email please try again"
      redirect("/login")
    end

    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
  #  if user && user.password  == params[:password]
      session[:user_id] = user.id
      #redirect "/bags"
      "ddddddddddd"
    else
      redirect to '/reset'
    end

  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
