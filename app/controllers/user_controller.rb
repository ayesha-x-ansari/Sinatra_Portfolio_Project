class UserController < ApplicationController

  get '/' do
      erb :home
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      erb :'/users/home'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == ""  || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect to '/signup'
    end

    user = User.find_by(:email => params[:email])
    if !user.nil?
      flash[:message] = "A account already exists with this email address"
      redirect("/signup")
    end

    if params[:password].size < 5
      flash[:message] = "Password cannot be less than 5 characters"
      redirect("/signup")
    end

    @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    erb :'/users/home'
  end

  get '/login' do
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      erb :'users/home'
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
      erb :'/users/home'
    else
      redirect to '/reset'
    end
  end

  get '/reset' do
    erb :'users/reset'
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
      erb :'/users/home'
      end

  #get '/users/:id' do
  #  if !logged_in?
  #    redirect '/bags'
  #  end

  #  @user = User.find(params[:id])
  #  if !@user.nil? && @user == current_user
  #    erb :'users/show'
  #  else
  #    redirect '/bags'
  #  end
  #end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
