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
});
