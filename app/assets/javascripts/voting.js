$(function() {
  // For every div that is an upvote button
  $('.link-upvote').click(function() {
    var div = $(this);
    var link_id = div.data('link-id');
    var url = '/links/' + link_id + '/upvote';
    $.ajax(url, {
      success: function(data) {
        if (data.show_login) {
          alert("You need to login to do that!");
        } else {
          div.text('▲'); 
        }
      }
    });
  })
  
  $('.link-downvote').click(function() {
    var div = $(this);
    var link_id = div.data('link-id');
    var url = '/links/' + link_id + '/downvote';
    $.ajax(url, {
      success: function(data) {
        if (data.show_login) {
          alert("You need to login to do that!");
        } else {
          div.text('▼'); 
        }
      }
    });
  })
});
