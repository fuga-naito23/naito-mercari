class CategoryController < ApplicationController

  def index
    @category = Category.all.order("id ASC").limit(13)
  end

  def show
    @category = Category.find(params[:id])
    categories = @category.subtree_ids
    @category_products = Product.where(category_id: categories).order("id DESC")
  end


end
