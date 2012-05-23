//= require jquery.pjax
//= require_tree .

$(function(){
  $('#wrapper a').live('click', function(event) {
    event.preventDefault();

    if (event.which > 1 || event.metaKey || event.ctrlKey) {
      return;
    } else if ($.support.pjax) {
      $.pjax({
        container: $("#wrapper"),
        url: $(this).attr('href'),
        timeout: 2000
       });
    }
  });
});
