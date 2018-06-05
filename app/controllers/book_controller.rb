class BookController < ApplicationController

    get '/books' do

      @books = Book.all

      if logged_in?
        @user = User.find_by_id(session[:user_id])
        erb :'/books/index'
      else
        redirect to '/login'
      end
    end

    get '/books/all' do
      @books = Book.all
      erb :'books/all'
    end

    get '/books/new' do
      erb :'books/new'
    end

    post '/books' do
      params[:book][:name] = params[:book][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      @book = Book.create(params[:book])
      params[:category][:name] = params[:category][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      if !params[:category][:name].empty?
        @book.categories << Category.create(params[:category])
      end
      @book.save
       redirect '/authors/home'
    end

    get '/books/:slug/edit' do
    #  @book = Book.find(params[:id])
      @book = Book.find_by_slug(params[:slug])
      erb :'books/edit'
    end



    post '/books/:slug' do
      @book = Book.find_by_slug(params[:slug])
      @book.update(params[:book])

      if !params[:category][:name].empty?
        @book.categories << Category.create(params[:category])
      end

      @book.save

    #  redirect to "/books/#{@book.id}"
    end

    get '/books/:id' do
    if logged_in?
      @book= Book.find_by_id(params[:id])
      erb :'/books/show'
    else
      redirect "/login"
    end
  end

  delete "/books/:id/delete" do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == current_user.id
        @book.delete
        flash[:message] = "Book deleted successfully"
      else
        flash[:message] = "You can't delete other Author's Book"
        redirect '/authors/home'
      end
    end
    redirect '/authors/home'
  end
end
