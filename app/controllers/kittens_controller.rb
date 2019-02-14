class KittensController < ApplicationController
  before_action :get_kitten, only: [:show, :edit, :update]
  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = 'Kitten Created!'
      redirect_to @kitten
    else
      flash.now[:warning] = 'How hard is it to create a kitten??'
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {render json: @kitten}
    end
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json {render json: @kittens}
    end
  end

  def edit

  end

  def update
    @kitten.update_attributes(kitten_params)
    flash[:success] = 'Kitten updated'
    redirect_to @kitten
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = 'Kitten deleted'
    redirect_to kittens_path
  end

  private

  def get_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name,:age,:cuteness,:softness)
  end
end
