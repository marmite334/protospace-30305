class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :new, :create, :show]

  def index
    @prototype = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    if user_signed_in?
      @prototype = Prototype.create(prototype_params)
      if @prototype.save
        redirect_to root_path(@prototype)
      else
        render :new
      end
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if user_signed_in?
      @prototype.update(prototype_params)
      if @prototype.save
        redirect_to prototype_path(@prototype)
      else
        render :edit
      end
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if user_signed_in?
      @prototype.destroy
      redirect_to root_path(@prototype)
    end
  end

  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
end
