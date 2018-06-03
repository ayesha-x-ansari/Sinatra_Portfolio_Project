class CategoryController < ApplicationController
set :views, Proc.new { File.join(root, "../views/categories") }

  get '/categories' do
    categories = Category.all
    @categories = categories.sort_by { |a| [ a.name ] }

    erb :index
  end
  get '/categories/:slug' do
    @category = Category.find_by_slug(params[:slug])
  #  erb :show
  end

  get '/category/new' do
    erb :new
  end

  post "/category" do
    #redirect_if_not_logged_in

    unless Category.valid_params?(params)
      redirect "/category/new?error=Category field cant be blank"
    end
    Category.create(params)
    redirect "/categories"
  end

  get '/category/:id/edit' do
  #  redirect_if_not_logged_in
  #  @error_message = params[:error]
    @category = Category.find(params[:id])
    erb :edit

  end

  post "/category/:id" do
    #  redirect_if_not_logged_in
      @category = Category.find(params[:id])
      unless Category.valid_params?(params)
      #  redirect "/bags/#{@bag.id}/edit?error=invalid golf bag"
      end
      @category.update(params)
    #  redirect "/bags/#{@bag.id}"
    end



end
