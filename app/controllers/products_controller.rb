class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create!(product_params)
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:name, :price, :delivery_fee_id, :delivery_way_id, :prefecture, images_attributes: %i[src id _destroy],images: [])
  end
end
