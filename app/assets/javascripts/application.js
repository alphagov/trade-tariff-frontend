//= require jquery.pjax
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-tab
//= require bootstrap-modal
//= require_tree .

$(function(){
  $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])')
    .pjax('[data-pjax-container]');
});
