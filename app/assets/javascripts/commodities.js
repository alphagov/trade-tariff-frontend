/*global $ */
/*jslint
 white: true */

/**
  @name commodities
  @namespace
  @description A set of methods for handling behaviours with Trade tariff commodities
  @requires jquery 1.6.2
*/

"use strict";
    
var commodities = {
    /**
      @name commodities.tree
      @object
      @description Behaviours for expandable trees    
    */
    tree : {
        /**
          @name commodities.tree.initialize
          @function
          @description expands/collapses nodes in a tree
        */
        initialize : function () {
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
        }
    },
    /**
      @name commodities.tabs
      @object
      @description Tabbing behaviours
    */
    tabs : {
        /**
          @name commodities.tabs.initialize
          @function
          @description adds tabbing behaviour
          @requires jquery.tabs.js
        */
        initialize : function () {
            $('div.tariff').tabs();
        }
    },
    /**
      @name commodities.tablePopup
      @object
      @description Adds popup behaviour to tariff table cells
    */
    tablePopup : {
        html : ['<div class="info-content"><h2>',
                '</h2>' +
                        '<p class="close"><a href="#">Close</a></p>' +
                        '<div class="info-inner">' +
                            '<p>Test content</p>' +
                        '</div>' +
                    '</div>' +
                '</div>'],
        /**
          @name commodities.tablePopup.adapt
          @function
          @description adapts the disclaimer popup for reuse
        */
        adapt : function () {
            
        },
        /**
          @name commodities.tablePopup.initialize
          @function
          @description initializes the popup behaviour
        */
        initialize : function () {
            var that = this;
            
            $('table td a.reference').on('click', function (e) {
                var title = that.html[0] + $(this).text() + that.html[1];
                BetaPopup.popup(title, 'tariff-info');
                that.adapt();
                
                return false;
            });
        }
    },
    /**
      @name initialize
      @function
      @description initializes namespace
    */
    initialize : function () {
        this.tree.initialize();
        this.tabs.initialize();
        this.tablePopup.initialize();
    }
};
    
// run scripts on DOMReady
$(function() {
    commodities.initialize();
});
