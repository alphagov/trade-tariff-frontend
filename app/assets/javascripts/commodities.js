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
            var $parentNodes = $('.has_children');
                
            if (!$parentNodes.length) { return; }
            
            $parentNodes.each(function (idx) {
                var $parentNode = $(this),
                    $childList;
                
                if ($parentNode[0].nodeName.toLowerCase() === 'dt') {                
                    $childList = $parentNode.siblings('dd').find('ul');
                } else {
                    $parentNode = $parentNode.children('span');
                    $childList = $parentNode.siblings('ul');
                }
                
                // hide all child lists
                $childList.addClass('visuallyhidden');
                // allow expansion based on clicking
                $parentNode.on('click', function(e) {
                    e.stopPropagation();
                    if ($childList.is('.visuallyhidden')) {
                        $childList.removeClass('visuallyhidden');
                        $(this).addClass('open');
                    }
                    else {
                        $childList.addClass('visuallyhidden');
                        $(this).removeClass('open');
                    }
                    
                    return false;
                }); 
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
            var $container = $('div.tariff');
            
            if ($container.find('.nav-tabs').length) {
                $container.tabs();    
            }            
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
                '</div>'],
        /**
          @name commodities.tablePopup.adapt
          @function
          @description adapts the disclaimer popup for reuse
          @param {Object} $this jQuery-wrapped link that fired the popup
        */
        adapt : function ($linkElm) {
            var url = $linkElm.attr('href'),
                $popupInner = $('#popup div.info-inner'),
                loader = '<img src="" alt="Content is loading" class="loader" />'
                onSuccess,
                onFail;
                
            onSuccess = function (data) {
                $popupInner.html(data);
            };
            
            onFail = function (jqXHR, txtStatus, errorThrown) {
                // to do
            };
            
            //$popupInner.html(loader);
            
            $.ajax({
                url : url,
                success : onSuccess,
                error : onSuccess
            });
        },
        /**
          @name commodities.tablePopup.initialize
          @function
          @description initializes the popup behaviour
        */
        initialize : function () {
            var that = this;
            
            $('table td a.reference').on('click', function (e) {
                var $this = $(this),                    
                    title = that.html[0] + 'Conditions' + that.html[1];
                    
                BetaPopup.popup(title, 'tariff-info');
                //that.adapt($this);
                
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
