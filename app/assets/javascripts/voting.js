$(document).on('page:change', function() {
  $('.link-upvote, .link-downvote').click(function(){
    console.log('click happened');
    var div = $(this);
    var link_id = div.data('link-id');
    var url, selector;
    if (div.hasClass('link-downvote')) {
      // We are making a downvote.
      var selector = '.link-upvote';
      var url = '/links/' + link_id + '/downvote';
      var shaded = '▼';
      var open = '▽';
      var opp_open = '△';
    } else {
      // We are making an upvote.
      var selector = '.link-downvote'
      var url = '/links/' + link_id + '/upvote'; 
      var shaded = '▲';
      var open = '△';
      var opp_open = '▽';
    }   
    var other_div = $(selector + "[data-link-id=" + link_id + "]"); 
    var score = $(".link-score[data-link-id=" + link_id + "]");

    var onSuccess = function(data) {
      console.log('onSuccess called');
      if (data.show_login) {
        var inst = $('[data-remodal-id=login-modal]').remodal();
        inst.open();
      } else {
        score.text(data.score);
        if (div.text() === shaded) {
          div.text(open)
        } else {
          div.text(shaded)
        }
        other_div.text(opp_open);
      }
    };
    
    $.ajax(url, {
      success: onSuccess
    });
  });
});