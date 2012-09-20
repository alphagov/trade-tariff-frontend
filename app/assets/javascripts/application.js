//= require jquery.pjax
//= require jquery.tabs
//= require jquery.datepicker
//= require jquery.history
//= require_tree .

$(function(){
  GOVUK.tariff.initialize();
  
  $('#pjax-container').pjax('a.js-pjax', {timeout: 4000})
    .on('pjax:success', function(){GOVUK.tariff.initialize()})
});
