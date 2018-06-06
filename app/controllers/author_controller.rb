class AuthorController < ApplicationController

  get '/authors/home' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/authors/home'
  end

  get '/signup' do
    if !session[:user_id]
      erb :'/authors/signup'
    else
      flash[:message] = "You are already a member"
      redirect '/authors/home'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == ""  || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect  '/signup'
    end

    user = User.find_by(:email => params[:email])
    if !user.nil?
      flash[:message] = "A account already exists with this email address"
      redirect '/signup'
    end

    if params[:password].size < 5
      flash[:message] = "Password cannot be less than 5 characters"
      redirect  '/signup'
    end

    @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    erb :'/authors/home'
  end

  get '/login' do
    if !session[:user_id]
      erb :'authors/login'
    else
      flash[:message] = "You are already logged in"
      redirect '/authors/home'
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

    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'/authors/home'
    else
      flash[:message] = "I think you forgot your password, please reset your password"
      redirect to '/reset'
    end
  end

  get '/reset' do
    if !session[:user_id]
      erb :'/authors/reset'
    else
      flash[:message] = "Please logout to reset your password"
      redirect '/authors/home'
    end
  end

  post '/reset' do
    if params[:email] == "" || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect to '/reset'
    end
    user = User.find_by_email(params[:email])
    user.password = params[:password]
    user.save
    session[:user_id] = user.id
    redirect '/authors/home'
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
