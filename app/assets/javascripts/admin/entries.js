var ready, entryArea, summaryArea;                                                                      
ready = function() {                                    
  $(document).foundation();                                                     
  
  entryArea = new SimpleMDE({ element: $("#entry_entry")[0] })
  summaryArea = new SimpleMDE({ element: document.getElementById('entry_summary') })

  $('#select-image-link').on('click', function() {
    loadPublishedImages();
    $('#select-image-modal').foundation('reveal', 'open');
  });

  $('#select-image-button').on('click', function() {
    $('#select-image-modal').foundation('reveal', 'close');
    $select = $('#image-select');
    $entryArea = $('#entry-entry'); 

    entryArea.drawSpecificImage(imageToUrl($select.val()));
  });

  $('#cancel-image-button').on('click', function() {
    $('#select-image-modal').foundation('reveal', 'close');
  });

};     

function imageToUrl(imageUUID) {
  return window.location.protocol + "//" + window.location.host + '/images/' + imageUUID
}

function loadPublishedImages() {
  $.get("/admin/images.json", function(data) {
    $select = $('#image-select')

    $select.find('option').remove();

    data.forEach(function(element) {
      $select.append($('<option>', {
        value: element['url_token'],
        text: element['title']
      }));
    });
  });
}

$(document).ready(ready);                                                       
$(document).on('turbolinks:load', ready);         
