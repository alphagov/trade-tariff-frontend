//= require jquery.pjax
//= require jquery.tabs
//= require jquery.history
//= require_tree .

$(function(){
  $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])')
    .pjax('[data-pjax-container]', { success : function () { commodities.initialize(); } });
    
  commodities.initialize();
});
