class CategoryController < ApplicationController
#set :views, Proc.new { File.join(root, "../views/categories") }

  get '/categories' do
    categories = Category.all
    @categories = categories.sort_by { |category| [ category.name ] }
    erb :'categories/index'
  end

  get '/category/new' do
    redirect_if_not_logged_in
    erb :'categories/new'
  end

  post "/category" do
    unless Category.valid_params?(params)
      redirect "/category/new?error=Input Error"
    end
    params[:name] = params[:name].split(" ").collect{|w| w.capitalize}.join(" ")
    @category  = Category.find_by_name(params[:name])
    if @category.nil?
      @category = Category.create(params)
      flash[:message] = "You created following category click delete, to delete this category."
      erb :'categories/show'
    else
      flash[:message] = "Category you tried to add is already present, please try again. "
      redirect '/category/new'
    end
  end

  get '/category/:slug/edit' do
    redirect_if_not_logged_in
    @category = Category.find_by_slug(params[:slug])
    @bookcategory = BookCategory.find_by(:category_id => @category.id)
    if @bookcategory.nil?
      erb :'categories/edit'
    else
      flash[:message] = "This category is in use you can't edit category which is in use: "
      redirect '/authors/home'
    end

  end

  post "/category/:id" do
    @category = Category.find(params[:id])
    unless Category.valid_params?(params)
      #  redirect "/bags/#{@bag.id}/edit?error=invalid golf bag"
    end
    params[:name] = params[:name].split(" ").collect{|w| w.capitalize}.join(" ")
    @category.update(params)
    erb :'categories/show'
  end

  get '/category/:slug' do
    redirect_if_not_logged_in
    @category = Category.find_by_slug(params[:slug])
    erb :'categories/show'
  end

  delete '/category/:id/delete' do #delete action
    @bookcategory = BookCategory.find_by_category_id(params[:id])
    if @bookcategory.nil?
      @category = Category.find_by_id(params[:id])
      @category.delete
      flash[:message] = "Your selected category is deleted "
      redirect '/authors/home'
    else
      flash[:message] = "This category is in use you can't delete category which is in use: "
      redirect '/authors/home'
    end
  end

end
