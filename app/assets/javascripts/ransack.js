$(document).on('turbolinks:load', function () {
  // ransackの検索ボタンを押すと発火イベント

  function buildHTML(product) {
    
    var html = `
    <div class='search'>
      <a href= "/products/${product.id}">
        <img class="top_image" src="${product.url}" >
      </a>
    </div> 
     `
    return html;
  }

  var category_id

  $(document).on("change",'.inputField__select', function (e) {

    e.preventDefault()
    category_id = $(this).val()
  })


  $(".side_bar").on('submit', function(e){
    e.preventDefault();
    
    var name_search = $('#q_name').val()
    var q = $('#q_sorts').val()

    console.log(category_id)
    $.ajax({
      type: 'GET',
      url: '/products/search',
      data: {name_search: name_search,q: {sorts: q, name_cont_any: name_search, category_id: category_id} },
      dataType: 'json'
    })

      .done(function (products) {
        $('.search').remove()
        html = "";
        products.forEach(function (product) {
          html += buildHTML(product)
        })
        $('.box').append(html);
        $(".submit").removeAttr("disabled");
      })
      
      .fail(function(){

      })
  })
});