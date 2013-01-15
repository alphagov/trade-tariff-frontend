//= require jquery.pjax
//= require jquery.tabs
//= require jquery.datepicker
//= require jquery.history
//= require_tree .

$(function(){
  GOVUK.tariff.onLoad();
  GOVUK.tariff.onContentLoad();
  
  $('#pjax-container').pjax('a.js-pjax', {timeout: 4000})
    .on('pjax:end', function(){
      GOVUK.tariff.onContentLoad(this);
    })
});
