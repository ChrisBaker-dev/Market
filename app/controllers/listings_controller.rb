class ListingsController < ApplicationController
  ## Authenticate user before any action
  before_action :authenticate_user!
  before_action :get_listing, only: [:update, :show, :destroy, :edit, :buy]
  # before_action :check_auth

  def index
    @listings = Listing.where("qty != 0 AND user_id != #{current_user.id}")
    # @produce = Produce.all
  end

  def new

    @listing = Listing.new
    # @produce = Produce.order(:name)
  end

  def update; end

  def delete
    redirect_to listings_path

  end

  def edit; end

  def show

  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
        redirect_to listing_path(@listing)
    else
        flash.now[:alert] = @listing.errors.full_messages
        render 'new'
    end
    # render action: 'index'
  end

  def destroy
    @listing.qty = 0
    @listing.save
    redirect_to listings_path
  end

  def buy
    @listing.decrement(:qty, 1)
    @listing.save!
    Order.create(user_id: current_user.id, listing_id: @listing.id).save


    redirect_to listings_path
  end

  def orders
    @orders = Order.where(user_id: current_user.id)
  end

  def posts
    @listings = Listing.where("qty != 0 AND user_id = #{current_user.id}")
  end


  private

  def get_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :qty, :image, :price)
  end
end
