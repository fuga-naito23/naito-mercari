class Product < ApplicationRecord
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  
  has_many_attached :images
  has_one :dealing
  
  belongs_to :user
  belongs_to :category
  belongs_to :brand

end
