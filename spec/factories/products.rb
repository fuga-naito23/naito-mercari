FactoryBot.define do
  factory :product do
    name { 'P1' }
    price { 300 }
    detail { 'p1detail' }
    condition { 1 }
    delivert_tax_payer { '送料込み（出品者負担）' }
    delivery_days {'1~2日で発送'}
    status { '出品中' }
    user
    category_id {33}
  end

  after(:build) do |product|
    product.image << build(:image)
end
