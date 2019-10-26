class PaymentsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_pay_jp_api_key, only: [:create]

  def new
    @product = Product.find(params[:product_id])
  end

  def create
    # 先ほど登録した顧客IDの定義
    @product = Product.find(params[:product_id])
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    # 金額。今回は固定で3500円としています。
    amount: @product.price,
    # 通貨の種類。日本円なのでjpyとします。
    currency: 'jpy',
    #トークンIDもしくは顧客IDは必須なので顧客IDを指定します。
    customer: customer_id,
    )
    redirect_to root_path
  end

  private
  def set_pay_jp_api_key
    # ここはテスト秘密鍵をセットします。
    Payjp.api_key = 'sk_test_f7f4b824e0a06f0c66943e26'
  end
end