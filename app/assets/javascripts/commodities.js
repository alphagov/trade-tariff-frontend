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
    
var GOVUK = GOVUK || {};

GOVUK.tariff = {
    /**
      @name GOVUK.tariff.tree
      @object
      @description Behaviours for expandable trees    
    */
    tree : {
        /**
          @name GOVUK.tariff.tree.initialize
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
      @name GOVUK.tariff.tabs
      @object
      @description Tabbing behaviours
    */
    tabs : {
        /**
          @name GOVUK.tariff.tabs.initialize
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
      @name GOVUK.tariff.tablePopup
      @object
      @description Adds popup behaviour to tariff table cells
    */
    tablePopup : {
        html : ['<div class="info-content"><h2 id="dialog-title" class="visuallyhidden">',
                '</h2>' +
                    '<p class="close"><a href="#">Close</a></p>' +
                    '<div class="info-inner">' +
                        '<p>Test content</p>' +
                    '</div>' +
                '</div>'],
        /**
          @name GOVUK.tariff.tablePopup.adapt
          @function
          @description adapts the disclaimer popup for reuse
          @param {Object} $this jQuery-wrapped link that fired the popup
        */
        adapt : function ($linkElm) {
            var url = $linkElm.attr('href'),
                $popup = $('#popup'),
                $popupInner = $popup.find('div.info-inner'),
                $dialogTitle = $('#dialog-title'),
                $closeBtn = $popup.find('.close a'),
                loader = '<img src="" alt="Content is loading" class="loader" />',
                htmlContent,
                onSuccess,
                onFail;
                
            onSuccess = function (data) {
                $popupInner.html(data);
            };
            
            onFail = function (jqXHR, txtStatus, errorThrown) {
                // to do
            };
            
            htmlContent = '<article>' +
            '<table>' +
                '<caption>Veterinary control for ERGA OMNES:</caption>' +
                '<thead>' + 
                  '<tr>' +
                    '<th>Condition</th>' +
                    '<th>Document code</th>' +
                    '<th>Requirement</th>' +
                    '<th>Action</th>' +
                    '<th>Duty expression</th>' +
                  '</tr>' +
                '</thead>' +        
                '<tbody>' +
                '<tr>' +
                    '<td>Presentation of a certificate/licence/document</td>' +
                    '<td>C640</td>' +
                    '<td>Presentation of a document:  Other certificates : Common veterinary entry document (CVED) in accordance with Commission Regulation (EC) No. 282/2004, used for veterinary checks on live animals.</td>' +
                    '<td>Import/export allowed after control</td>' +
                    '<td></td>' +
                '</tr>' +
                '<tr>' +
                    '<td>Presentation of a certificate/licence/document</td>' +
                    '<td></td>' +
                    '<td></td>' +
                    '<td>Import/export not allowed after control</td>' +
                    '<td></td>' +
                '</tr>' +
                '</tbody>' +
              '</table>' +
            '</article>';
            
            //$popupInner.html(loader);
            
            //$.ajax({
            //    url : url,
            //    success : onSuccess,
            //    error : onSuccess
            //});
            
            $popupInner.html(htmlContent);
            
            // reset the tabindex of the heading
            $dialogTitle
                .attr('tabindex', 0)
                .focus();
            $popup
                .attr({
                    'tabindex' : -1,
                    'role' : 'dialog',
                    'aria-labelledby' : 'dialog-title'
                });                
            
            // return focus to the trigger link when the lightbox closes
            $closeBtn.on('click', function (e) {
                $linkElm.focus()
            });
            
            // dialogs need focus to be retained until closed so control tabbing
            $popup.on('keydown', function (e) {
                if (e.which == 9){
                    
                    // cancel tabbing from the close button (assumed this is the last link)
                    if (e.target.nodeName.toLowerCase() === 'a') {
                        if (!event.shiftKey) {
                            return false;
                        }
                    } else {
                        
                        // popup removes tabindex from the title by default so re-apply it
                        if (e.target.nodeName.toLowerCase() === 'h2') {                            
                            e.target.tabIndex = 0;                            
                        }
                        
                        // cancel reverse-tabbing out of the popup
                        if (event.shiftKey) {
                            return false;
                        }
                    }                    
                }
                
                return true;
            });
        },
        /**
          @name GOVUK.tariff.tablePopup.initialize
          @function
          @description initializes the popup behaviour
        */
        initialize : function () {
            var that = this;
            
            $('table td a.reference').on('click', function (e) {
                var $this = $(this),                    
                    title = that.html[0] + 'Conditions' + that.html[1];
                
                BetaPopup.maskOpacity = 0.2;
                BetaPopup.popup(title, 'tariff-info');
                that.adapt($this);
                
                return false;
            });
        }
    },
    /**
      @name GOVUK.tariff.datePicker
      @object
      @description initializes namespace
    */
    datePicker : {
        /**
          @name GOVUK.tariff.datePicker.initialize
          @function
          @description initializes namespace
        */
        initialize : function () {
            var $form = $('#date-filter'),
                $input = $form.find('input.date'),
                $btn = $form.find('input.button'),
                $changeLink = $('<a href="#">Change date</a>');
            
            $input.datepicker({
                dateFormat : 'dd/mm/yy'    
            });
            
            $form.append($changeLink);
            
            $changeLink.on('click', function (e) {
                $form.addClass('editMode');
                $input.focus();
                $(this).remove();
                $btn.show();
                
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
        var that = this;
        
        this.tree.initialize();
        this.tabs.initialize();
        this.tablePopup.initialize();
        this.datePicker.initialize();
        
        $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])')
            .pjax('[data-pjax-container]', { success : function () { that.initialize(); } });
    }
};
