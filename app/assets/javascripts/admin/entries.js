var ready;                                                                      
ready = function() {                                    

  var entryCursorPosition = 0

  $('#select-image-link').on('click', function() {
    loadPublishedImages();
    $('#select-image-modal').foundation('reveal', 'open');
  });

  $('#select-image-button').on('click', function() {
    $('#select-image-modal').foundation('reveal', 'close');
    $select = $('#image-select');
    $entryArea = $('#entry-entry'); 

    insertAtCursor($entryArea, $select.val());
  });

  $('#cancel-image-button').on('click', function() {
    $('#select-image-modal').foundation('reveal', 'close');
  });

};     

function insertAtCursor(myField, myValue) {
    //IE support
    if (document.selection) {
        myField.focus();
        sel = document.selection.createRange();
        sel.text = myValue;
    }
    //MOZILLA and others
    else if (myField.selectionStart || myField.selectionStart == '0') {
        var startPos = myField.selectionStart;
        var endPos = myField.selectionEnd;
        myField.value = myField.value.substring(0, startPos)
            + myValue
            + myField.value.substring(endPos, myField.value.length);
    } else {
        myField.value += myValue;
    }
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

/*
select-image-modal
select-image-button
cancel-image-button
*/
$(document).ready(ready);                                                       
$(document).on('page:load', ready);         
