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
    binding.pry
    redirect_to root_path
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, :size, :brand_id, :detail, :condition, :delivery_tax_payer, :delivery_agency, :delivery_days, images: []).merge(user_id: current_user.id)
  end
end
