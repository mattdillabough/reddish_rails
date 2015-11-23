$(function() {
  // For every div that is an upvote button
  $('.link-upvote').click(function() {
    var div = $(this);
    var link_id = div.data('link-id');
    var url = '/links/' + link_id + '/upvote';
    $.ajax(url, {
      success: function() {
        div.text('▲');
      }
    });
  })
});