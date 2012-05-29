//= require jquery.pjax
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-modal
//= require_tree .

$(function(){
  $('#wrapper a:not(.no-pjax)').live('click', function(event) {
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

  $("a[ref='popover']").each(function(){
    $(this).popover();

    $(this).click(function(e){
      e.preventDefault();
    });
  });
});
