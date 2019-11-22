require 'rails_helper'

RSpec.describe Product, type: :model do
  
  context '保存できる' do
    it 'ActiveRecordのnoproductモデルが保存できる', hoge: true do
      user = User.create(
        nickname: 'Alice',
        email: 'test@gmail.com',
        password: 'a' * 8,
        password_confirmation: 'a' * 8,
      )
      category = Category.find_by(name: 'メンズ').indirects.first
      product = Product.new(
        name: 'P1',
        price: 300,
        detail: 'P1:detail',
        condition: 1,
        delivery_tax_payer: '送料込み（出品者負担）',
        category_id: category.id
      )
      product.images.new(image: 'test.jpg')
      product.valid?
      expect(product).to be_valid
    end  

  end  
  context '保存できない' can_save: true do
    it 'Productsのfactoryを使って保存できる' do
      product = build(:product)
      product.valid?
      except(product).to be_valid
    end
    it '' do
    end  
  end  
end
