class CategoryController < ApplicationController
set :views, Proc.new { File.join(root, "../views/categories") }

  get '/categories' do
    @categories = Category.all
    erb :index
  end
  get '/categories/:slug' do
    @category = Category.find_by_slug(params[:slug])
  #  erb :show
  end
end
