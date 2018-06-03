class BookController < ApplicationController

    get '/books' do
      @books = Book.all
      erb :'books/index'
    end

    get '/books/new' do
      erb :'books/new'
    end


    get '/books/:id' do
      @book = Book.find(params[:id])
      erb :'books/show'
    end

    get '/books/:id/edit' do
      @book = Book.find(params[:id])
      erb :'books/edit'
    end

    post '/books' do
      @book = Book.create(params["book"])
      if !params[:category][:name].empty?
        @book.categories << Category.create(params[:category])
      end


      @figure.save
      binding.pry
      redirect to "/figures/#{@figure.id}"
    end

    post '/books/:id' do
      @book = Book.find(params[:id])
      @book.update(params[:book])

      if !params[:category][:name].empty?
        @book.categories << Category.create(params[:category])
      end

      @book.save
      binding.pry
      redirect to "/books/#{@book.id}"
    end

end
