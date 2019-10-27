class ProductsController < ApplicationController
  
  def index
    @products = Product.limit(20).order("id DESC")
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

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end

  def destroy
    product = Product.find(params[:id])

    if product.user_id == current_user.id
      product.destroy
      redirect_to root_path
    else
      redirect_to root_path  
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, :size, :brand_id, :detail, :condition, :delivery_tax_payer, :delivery_agency, :delivery_days, images: []).merge(user_id: current_user.id)
  end
end
