class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :destroy, :update]
  before_action :set_category, only: [:new, :edit, :search]

  def index
    @products = Product.limit(20).order("id DESC")

    redies = Category.find(1)
    redies_categorys_id = redies.subtree_ids
    @redies_categorys = Product.where(category_id: redies_categorys_id).limit(5).order("id DESC")
    
    mens = Category.find(2)
    mens_categorys_id = mens.subtree_ids
    @mens_categorys = Product.where(category_id: mens_categorys_id).limit(5).order("id DESC")
    

  end

  def new
    @product = Product.new
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
    if @product.update(product_params)
      delete_params[:delete_ids].each do |delete_id|
        image = @product.images.find(delete_id)
        image.purge
      end
      redirect_to root_path
    else  
      render :edit
    end
  end

  def destroy

    if @product.destroy && @product.user_id == current_user.id
      redirect_to root_path
    else
      flash[:alert] = '削除に失敗しました！'
      redirect_to product_path(@product)
    end

  end

  def search

    respond_to do |format|
      format.html{


        if params[:search] == ""
          redirect_to root_path
          return
        end

        @products = Product.search(params[:search])
        params[:q] = { sorts: 'id DESC' }
        set_ransack
      }

      format.json{

        params[:q][:sorts] = 'id DESC' if params[:q][:sorts] = ""

        params[:q][:name_cont_any] = params[:name_search].squish.split(" ") if params[:q][:name_cont_any]
        @category = Category.find(params[:q][:category_id])
        params[:q][:category_id] = @category.subtree_ids
        set_ransack 

      }
    end
  end



  private

  def product_params
    params.require(:product).permit(:name, :price, :category_id, :size, :brand_id, :detail, :condition, :delivery_tax_payer, :delivery_agency, :delivery_days, images: []).merge(user_id: current_user.id)
  end

  def delete_params
    params.require(:product).permit(:delete_ids => [])
  end


  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @parents = Category.all.order("id ASC").limit(13)
    # TODO：カテゴリが編集ページでも出るには？？
    # @child_categories = Category.where('ancestry = ?', "#{params[:parent]}")
    # @grandchild_categories = Category.where('ancestry LIKE ?', "%/#{params[:child]}")
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

  def set_ransack
    
     ## 共通の処理
     @q = Product.ransack(params[:q])
     @products_ransack = @q.result(distinct: true)
     @order = [["価格が安い順", "price ASC"], ["価格が高い順", "price DESC"], ["出品が新しい順", "created_at DESC"], ["出品が古い順", "created_at ASC"]]    

  end
end
