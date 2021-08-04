class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /users/:user_id/items
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  # GET /users/:user_id/items/:id
  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  # POST /users/:user_id/items
  def create
    # byebug
    # if params[:user_id]
    user = User.find(params[:user_id])
    new_item = user.items.create(item_params)
    # else
    #   items = User.items
    # end
    render json: new_item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { error: "Item(s) not found" }, status: :not_found
  end

end
