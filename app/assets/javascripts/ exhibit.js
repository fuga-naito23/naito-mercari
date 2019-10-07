$(function () {
  var image_num = 0;
  //画像が追加されると
  $(document).on('change', 'input[type="file"]', function (e) {
    var index = $(this).attr("data-id");
    //プレビューされると
    var files = e.target.files;
    var preview = $('.input-box__image');
    handleFiles(files);
    
    
    function handleFiles(files) {
      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var imageType = /image.*/;
        
        if (!file.type.match(imageType)) {
          continue;
        }
        var src = files[i];
        src = window.URL.createObjectURL(src);
        console.log(src);
        
        function imageHtml(img) {
          var html = `
          <div class = "image">
          <img class = "preview-image" src= "${src}" data-id="${index}">
          <div class = "sell-upload-button">
          <a href class = "sell-upload-edit" data-id="${index}">編集</a>
          <a href class = "sell-upload-delete" data-id="${index}">削除</a>
          </div>
          </div>
          `
          return html
        }
        var select = $(imageHtml())
        
        
        //display noneでかくす
        $('.uploadInfo').css('display', 'none');
        
        //新しいinputをだす
        console.log(index)
        if ($(`.preview-image[data-id=${index}]`)[0]) {
          $(`.preview-image[data-id=${index}]`).attr(`src`, src)
          console.log(this)
          return false
        };
        preview.append(select);
        image_num++;
        // var image_num_del = image_num - 1;
        // var image_num_edit = image_num - 1;
        apendInputHtml(image_num)
        $('.input-box__image').attr("for", `product_images${image_num}`)
        function apendInputHtml(image_num) {
          var html = `
        <input data-id="${image_num}" type="file" name="product[images]" id="product_images${image_num}">
        `
          $(".input-box__image").append(html)
        }
      }
      }
    });

  $('.images').on('click', '.sell-upload-delete', function (e) {

    e.preventDefault();
    var id = $(this).data('id');
    $(this).parents(".image").remove()
    $(`[data-id=${id}]`).remove()
  })

  $('.images').on('click', '.sell-upload-edit', function (e) {
    e.preventDefault()
    var id = $(this).data('id');
    console.log(id)
    $(`input[data-id=${id}]`).click()
    // $(`[data-id=${id}]`).remove()
  })
})