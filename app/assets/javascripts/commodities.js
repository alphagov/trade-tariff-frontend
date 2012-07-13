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
    tabs : (function () {
        //var tabset = function (context) {
        //    var that = this;
        //    
        //    this.$tabs = $('.nav-tabs a', context);
        //    this.$tabWrappers = $tabs.closest('li');
        //    this.$tabPanes = $('.tab-pane', context);
        //        
        //    this.$tabPanes.not('.active').hide();
        //    
        //    // tabs
        //    this.$tabs.each(function (idx) {
        //        var $this = $(this);
        //        
        //        $this.on('click', function(e) {
        //            var tabId = this.href.match(/#\w+$/);
        //            
        //            if (that.$tabWrappers.eq(idx).hasClass('active')) {
        //                return;
        //            }
        //            
        //            if (tabId) {
        //                that.open(idx, tabId[0]);
        //            }
        //            
        //            return false;
        //        });
        //    });
        //};
        //
        //tabset.prototype = {
        //    open : function (idx, id) {
        //        this.$tabWrappers.removeClass('active');
        //        this.$tabWrapper
        //            .eq(idx)
        //            .addClass('active');
        //        
        //        
        //        this.$tabPanes.hide();
        //        $(id).show();
        //    }
        //}
        
        // object that will be assigned to commodities.tabs
        return {
            initialize : function () {
                //$('.tab-content').each(function () {
                //    new tabset(this);    
                //});
                $('div.tariff').tabs();
            }    
        }
        
    }()),
    initialize : function () {
        this.tree.initialize();
        this.tabs.initialize();
    }
};
    
// run scripts on DOMReady
$(function() {
    commodities.initialize();
});
