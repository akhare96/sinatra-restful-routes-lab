class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get "/" do
    redirect "/recipes"
  end

  #displays all the recipes
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
    #shows all instances of recipes
    #contains link to each recipes show page #/recipes/:id
    #contains link to create a new recipe "/recipes/new"
  end

  get "/recipes/new" do
    erb :new
    #form submit POST "/recipes" with new recipe attributes
  end

  #creates new recipe using params hash
  #redirects to recipe show page "/recipes/:id"
  post "/recipes" do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  #displays chosen recipe
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
    #displays name, ingredients, cook_time
    #form to delete recipe - deletes via DELETE request
    #link to edit recipe - "/recipes/:id/edit"
  end

  #edits single recipe - name, ingredients, cook_time
  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
    #shows ingredients before editing
    #submit form to edit recipe - updates via PATCH request
  end

  #updates a recipe
  #redirects to recipe show page
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  #deletes recipe
  #redirects to "/recipes"
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

end
