class CategoryController < ApplicationController
#set :views, Proc.new { File.join(root, "../views/categories") }

  get '/categories' do
     categories = Category.all
     @categories = categories.sort_by { |category| [ category.name ] }
    erb :'categories/index'
  end

  get '/categories/:slug' do
    @category = Category.find_by_slug(params[:slug])
    erb :'categories/show'
  end

  get '/category/new' do
    erb :'categories/new'
  end

  post "/category" do
    redirect_if_not_logged_in
    unless Category.valid_params?(params)
      redirect "/category/new?error=Input Error"
    end
    params[:name] = params[:name].split(" ").collect{|w| w.capitalize}.join(" ")
    @category = Category.create(params)
    erb :'categories/show'
  end

  get '/category/:id/edit' do
     redirect_if_not_logged_in
  #  @error_message = params[:error]
    @category = Category.find(params[:id])
    erb :'categories/edit'

  end

  post "/category/:id" do
    #  redirect_if_not_logged_in
      @category = Category.find(params[:id])
      unless Category.valid_params?(params)
      #  redirect "/bags/#{@bag.id}/edit?error=invalid golf bag"
      end
      params[:name] = params[:name].split(" ").collect{|w| w.capitalize}.join(" ")
      @category.update(params)
      erb :'categories/show'
    end

    delete '/category/:id/delete' do #delete action
      @category = Category.find_by_id(params[:id])
      @category.delete
      erb :'categories/deleted'
  end

end
