/*global $ */
/*jslint
 white: true */
$(function() {
    "use strict";
    // hide all child lists
    $('ul.commodities .has_children > ul').addClass('visuallyhidden');
    // allow expansion based on clicking
    $('li.has_children>span').on('click', function(e) {
        e.stopPropagation();
        var childList = $(this).siblings('ul');
        if (childList.is('.visuallyhidden')) {
            childList.removeClass('visuallyhidden');
            $(this).addClass('open');
        }
        else {
            childList.addClass('visuallyhidden');
            $(this).removeClass('open');
        }
    });
    
    var $tabs = $('.nav-tabs a'),
        $tabWrappers = $tabs.closest('li'),
        $tabPanes = $('.tab-pane');
        
    $tabPanes.not('.active').hide();
    
    // tabs
    $tabs.each(function (idx) {
        var $this = $(this);
        
        $this.on('click', function(e) {
            var tabId = this.href.match(/#\w+$/),
                $tabWrapper = $tabWrappers.eq(idx);
            
            if ($tabWrapper.hasClass('active')) {
                return;
            }
            
            if (tabId) {
                $tabWrappers.removeClass('active');
                $tabWrapper.addClass('active');
                
                
                $tabPanes.hide();
                $(tabId[0]).show();
            }
            
            return false;
        });
    });
    
});
