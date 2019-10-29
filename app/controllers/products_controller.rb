class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :destroy]

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
  end

  def edit
  end

  def update
  end

  def destroy

    if @product.destroy && @product.user_id == current_user.id
      redirect_to root_path
    else
      flash[:alert] = '削除に失敗しました！'
      redirect_to product_path(@product)
    end

  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, :size, :brand_id, :detail, :condition, :delivery_tax_payer, :delivery_agency, :delivery_days, images: []).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
