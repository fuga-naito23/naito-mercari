// hidden_fieldで削除用のidをセット
// 
$(document).on('turbolinks:load', function () {

  function setHiddenfield(id) {
    var html = `
    <input name='product[delete_ids][]' class='delete' type='hidden' value='${id}'>    `
    $('.delete_images').append(html)
  }

  $('.images').on('click', '.sell-edit-delete', function (e) {
    e.preventDefault();
    var id = $(this).data('id')
    setHiddenfield(id)
    $(this).parents(".image").remove()
  })


})