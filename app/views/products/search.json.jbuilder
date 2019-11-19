json.array! @products_ransack do |product|
  json.url url_for(product.images[0])
  json.id product.id
end