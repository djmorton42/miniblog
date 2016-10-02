var ready, commentArea, runReady = false;                                                                      

ready = function() {                                    
  if (runReady) {
    return;
  } else {
    runReady = true;
  }

  $(document).foundation();                                                     
  
  commentArea = new SimpleMDE(
    {
      element: $("#comment_comment")[0],
      hideIcons: ['image', 'link']
    }
  )
};     

$(document).ready(ready);                                                       
$(document).on('turbolinks:load', ready);         
