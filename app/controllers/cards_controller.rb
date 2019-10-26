class CardsController < ApplicationController
  # APIを使用する際のセキュリティが強化され、エラーがでてしまうので、createだけ外しておく
  protect_from_forgery :except => [:create]
  # 先ほどの秘密鍵をbefore_actionで実行
  before_action :set_payjp_api_key, only: [:create]

  def new
  end

  def create
    # Payjp::Customer.createで顧客IDを作成します。
    # 引数に入れる値はいくつか増やすことができますが、今回はdescription(概要)とcard(カードトークン)の最小限にします。
    customer = Payjp::Customer.create(
    description: 'ユーザー2の顧客情報',
    card: params[:pay_id]
  )
  card = Card.new(
     pay_id: params[:pay_id],
     customer_id: customer.id,
     user_id: current_user.id
   )
   card.save
  end

  private

  def set_payjp_api_key
    Payjp.api_key = 'sk_test_f7f4b824e0a06f0c66943e26'
  end
end