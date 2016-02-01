$(function() {
  // For every div that is an upvote button
  $('.link-upvote').click(function() {
    var div = $(this);
    var link_id = div.data('link-id');
    var div1 = $(".link-downvote[data-link-id=" + link_id + "]");
    var score = $(".link-score[data-link-id=" + link_id + "]")
    var url = '/links/' + link_id + '/upvote';
    $.ajax(url, {
      success: function(data) {
        if (data.show_login) {
          alert("You need to login to do that!");
        } else {
          score.text(data.score);
          if (div.text() === '▲') {
            div.text('△')
          } else {
            div.text('▲')
          }
          div1.text('▽');
          
        }
      }
    });
  })
  
  $('.link-downvote').click(function() {
    var div = $(this);
    var link_id = div.data('link-id');
    var div1 = $(".link-upvote[data-link-id=" + link_id + "]");
    var score = $(".link-score[data-link-id=" + link_id + "]")
    var url = '/links/' + link_id + '/downvote';
    $.ajax(url, {
      success: function(data) {
        if (data.show_login) {
          alert("You need to login to do that!");
        } else {
          score.text(data.score);
          if (div.text() === '▼') {
            div.text('▽')
          } else {
            div.text('▼')
          } 
          div1.text('△');
        }
      }
    });
  })
});
