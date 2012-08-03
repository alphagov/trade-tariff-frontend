//= require jquery.pjax
//= require jquery.tabs
//= require jquery.datepicker
//= require jquery.history
//= require_tree .

$(function(){
  GOVUK.tariff.initialize();
  
  $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax('[data-pjax-container]', 
    { 
      timeout: 6000,
      success: function () { 
        GOVUK.tariff.initialize();
      }
    }
   );
});
