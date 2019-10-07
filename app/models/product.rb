class Product < ApplicationRecord
  
  
  has_many_attached :images
  has_one :dealing
  
  belongs_to :user
  belongs_to :category
  belongs_to :brand

  enum status: { old_lv_0: 0, old_lv_1: 1,old_lv_2: 2,old_lv_3: 3,old_lv_4: 4 }

end
