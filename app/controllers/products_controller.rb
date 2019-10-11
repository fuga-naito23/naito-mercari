class ProductsController < ApplicationController
  
  def index
  end

  def new
    @product = Product.new
    @parents = Category.all.order("id ASC").limit(13)
    
    if params[:parent]
      @child_categories = Category.where('ancestry = ?', "#{params[:parent]}")
    else
     @grandchild_categories = Category.where('ancestry LIKE ?', "%/#{params[:child]}")
    
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    product = Product.create(product_params)
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:name, :price, :delivery_fee_id, :delivery_way_id, :prefecture, images_attributes: %i[src id _destroy],images: [])
  end
end
