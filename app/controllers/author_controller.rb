class AuthorController < ApplicationController

  get '/authors/home' do
    redirect_if_not_logged_in
    @author = Author.find_by_id(session[:author_id])
    erb :'/authors/home'
  end

  get '/signup' do
    if !session[:author_id]
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

    user = Author.find_by(:email => params[:email])
    if !user.nil?
      flash[:message] = "A account already exists with this email address"
      redirect '/signup'
    end

    if params[:password].size < 5
      flash[:message] = "Password cannot be less than 5 characters"
      redirect  '/signup'
    end

    if params[:password]  !=  params[:password_confirmation]
      flash[:message] = "Passwords do not match"
      redirect  '/signup'
    end

    @author = Author.create(:name => params[:name], :email => params[:email], :password => params[:password], :moms_maiden_name => params[:moms_maiden_name])
    session[:author_id] = @author.id
    erb :'/authors/home'
  end

  get '/login' do
    if !session[:author_id]
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

    author = Author.find_by(:email => params[:email])
    if author.nil?
      flash[:message] = "Can't find your email please try again"
      redirect("/login")
    end
    session[:try_count]  = session[:try_count]  +  1

    @author = Author.find_by(:email => params[:email])
    if @author && @author.authenticate(params[:password])
      session[:author_id] = @author.id
      erb :'/authors/home'
    else
      if session[:try_count] > 2
        flash[:message] = "I think you forgot your password, please reset your password"
        session[:try_count] = 0
        redirect to '/reset'
      else
        redirect("/login")
      end
    end
  end

  get '/reset' do
    if !session[:author_id]
      erb :'/authors/reset'
    else
      flash[:message] = "Please logout to reset your password"
      redirect '/authors/home'
    end
  end

  post '/reset' do
    author = Author.find_by_email(params[:email])
    if author.moms_maiden_name  != params[:moms_maiden_name]
      flash[:message] = "Please enter correct Mother's Maiden Name"
      redirect to '/reset'
    end

    if params[:password].size < 5
      flash[:message] = "Password cannot be less than 5 characters"
      redirect  '/signup'
    end

    if params[:email] == "" || params[:password] == ""
      flash[:message] = "All fields should be filled"
      redirect to '/reset'
    end

    if params[:password]  !=  params[:password_confirmation]
      flash[:message] = "Passwords do not match"
      redirect  '/reset'
    end

    author.password = params[:password]
    author.save
    session[:author_id] = author.id
    redirect '/authors/home'
  end

  get '/logout' do
    if session[:author_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
