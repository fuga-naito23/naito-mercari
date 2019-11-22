class Product < ApplicationRecord
  
  
  has_many_attached :images
  has_one :dealing
  
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  include JpPrefecture
  jp_prefecture :delivery_agency, method_name: :pref
  enum condition: { old_lv_0: 0, old_lv_1: 1,old_lv_2: 2,old_lv_3: 3,old_lv_4: 4 }


  def self.search(search)
    Product.where(['name LIKE ?', "%#{search}%"])
  end

  # validations
  validates :name, :price , :detail , :condition, :delivery_tax_payer,
            :delivery_days,presence: true
  validates :name, length: { in: 1..40}
  validates :detail, length: { in: 1..1000}
  validates :price, numericality: { greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999 }
  validates :images, length: { in: 1..10 }




end
