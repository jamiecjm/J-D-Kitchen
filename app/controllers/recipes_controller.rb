class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]



  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all.includes(:user,:favourites)
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to @recipe
    else
      flash.now[:danger] = @recipe.errors.full_messages.first
      render "new"
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe updated!"
      redirect_to @recipe
    else
      flash.now[:danger] = @recipe.errors.full_messages.first
      render "edit"
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:user_id,:title,:description,:servings,:cooktime1,:cooktime2,:food_photo,:cuisine_id,:main_ingredient_id,
                                      ingredients_attributes: [:id,:_destroy,:amount,:unit,:ingredient],
                                      instructions_attributes: [:id,:_destroy,:step,:title,:description,:step_photo])
    end


end


