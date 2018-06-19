class BookController < ApplicationController

    get '/books' do
      @books = Book.all
      if logged_in?
      #  @author = Author.find_by_id(session[:author_id])
        redirect '/authors/home'
      else
        redirect to '/login'
      end
    end

    get '/books/all' do
      @books = Book.all
      erb :'books/all'
    end

    get '/books/new' do
      redirect_if_not_logged_in
      erb :'books/new'
    end

    post '/books' do
      params[:book][:name] = params[:book][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      @book = Book.create(params[:book])
      params[:category][:name] = params[:category][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      if !params[:category][:name].empty?
        @category  = Category.find_by_name(params[:category][:name])
        if @category.nil?
          @book.categories << Category.create(params[:category])
        else
          flash[:message] = "Category you tried to add is already present, please try again. "
          redirect '/books/new'
        end

      end
      @book.save
      flash[:message] = "Your book is added"
      redirect '/authors/home'
    end

    get '/books/:slug/edit' do
      redirect_if_not_logged_in
      @book = Book.find_by_slug(params[:slug])
      erb :'books/edit'
    end

    patch '/books/:slug' do
      params[:book][:name] = params[:book][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      @book = Book.find_by_slug(params[:slug])
      @book.update(params[:book])

      params[:category][:name] = params[:category][:name].split(" ").collect{|w| w.capitalize}.join(" ")
      if !params[:category][:name].empty?
        @category  = Category.find_by_name(params[:category][:name])
        if @category.nil?
          @book.categories << Category.create(params[:category])
        else
          flash[:message] = "Category you tried to add is already present, please try again. "
          redirect '/authors/home'
        end
      end
      @book.save
      flash[:message] = "Your book is updated"
      redirect '/authors/home'
    end

    get '/books/:slug' do
      redirect_if_not_logged_in
      @book= Book.find_by_slug(params[:slug])
      erb :'/books/show'
  end

  delete "/books/:id/delete" do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.author_id == current_user.author_id
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
