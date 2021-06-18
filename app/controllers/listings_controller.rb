class ListingsController < ApplicationController
  ## Authenticate user before any action
  before_action :authenticate_user!
  before_action :get_listing, only: [:update, :show, :destroy, :edit, :buy]

  def index
    # Grab all listings that dont belong to the current user and 
    # are still active - qty is greater than 0
    @listings = Listing.where("qty != 0 AND user_id != #{current_user.id}")
  end

  def new

    @listing = Listing.new
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
  end

  def destroy
    # Set listing quantity to 0 when deleting - if destroy then
    # there will be referential integrity issue on orders
    @listing.qty = 0
    @listing.save
    redirect_to listings_path
  end

  def buy
    Listing.decrease_qty(@listing) # Lower quantity of listing by one
    Order.create(user_id: current_user.id, listing_id: @listing.id).save # Create Order entry
    redirect_to listings_path
  end

  def orders
    # Get all orders belonging to current user
    @orders = Order.where(user_id: current_user.id)
  end

  def posts
    # Grab all listings that belong to the current user and
    # are still active - qty is greater than 0
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
