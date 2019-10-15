$(function () {
  
  $('.product_image').mouseover(function () {
  
  var change = $(this).attr('src')
  $('.top_image').attr('src', change)

  })
  
})