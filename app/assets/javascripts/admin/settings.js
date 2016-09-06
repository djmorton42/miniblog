var ready, bioArea, copyrightArea, runReady = false;

ready = function() {                                    
  if (runReady) {
    return;
  } else {
    runReady = true;
  }

  $(document).foundation();                                                     

  $('.color-picker').colorPicker();

  bioArea = new SimpleMDE({ element: $("#setting_bio")[0] })
  copyrightArea = new SimpleMDE({ element: $("#setting_copyright")[0] })
  
  var areaToModify = null;

  $('#select-bio-image-link').on('click', function() {
    areaToModify = bioArea;
    loadPublishedImages();
    $('#select-image-modal').foundation('reveal', 'open');
  });
  
  $('#select-copyright-image-link').on('click', function() {
    areaToModify = copyrightArea;
    loadPublishedImages();
    $('#select-image-modal').foundation('reveal', 'open');
  });

  $('#select-image-button').on('click', function() {
    $('#select-image-modal').foundation('reveal', 'close');
    $select = $('#image-select');

    areaToModify.drawSpecificImage(imageToUrl($select.val()));
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
