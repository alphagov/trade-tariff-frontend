/*global $ */
/*jslint
 white: true */
$(function() {
    "use strict";
    // hide all child lists
    $('ul.commodities .has_children > ul').addClass('visuallyhidden');
    // allow expansion based on clicking
    $('li.has_children').on('click', function(e) {
        e.stopPropagation();
        var child = $('>ul', this);
        if (child.is('.visuallyhidden')) {
            child.removeClass('visuallyhidden');
            $(this).addClass('open');
        }
        else {
            child.addClass('visuallyhidden');
            $(this).removeClass('open');
        }
    });
});
