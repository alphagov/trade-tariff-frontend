/*global $ */
/*jslint
 white: true */

"use strict";

/**
 * @name GOVUK
 * @namespace
 * @description Global namespace for gov.uk
 * @requires jquery 1.6.2
*/ 
var GOVUK = GOVUK || {};

/**
  @name GOVUK.tariff
  @memberOf GOVUK
  @namespace
  @description A set of methods for handling behaviours with Trade tariff commodities
  @requires jquery 1.6.2
*/
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
            var $parentNodes = $('.has_children'),
                isCommodityTree = false,
                development = $('#development'),
                $controls,
                effectAll;

            if (!$parentNodes.length) { return; }

            $parentNodes.each(function (idx) {
                var $parentNode = $(this),
                    $childList;

                if ($parentNode[0].nodeName.toLowerCase() === 'dt') {
                    $childList = $parentNode.siblings('dd').find('ul');
                } else {
                    isCommodityTree = true;
                    $parentNode = $parentNode.children('span');
                    $childList = $parentNode.siblings('ul');
                }

                // hide all child lists
                $childList.addClass('visuallyhidden');

                // Matt's hack
                if (development){
                    if ($childList.is('.visuallyhidden')) {
                        $childList.removeClass('visuallyhidden');
                        $(this).addClass('open');
                    }
                }
                
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

            if (isCommodityTree) {
                $controls = '<ul class="tree-controls">' +
                                '<li><a href="#">open all</a></li>' +
                                '<li><a href="#">close all</a></li>' +
                            '</ul>';
                effectAll = function (ctrlIdx) {
                    $parentNodes.each(function (idx) {
                        var $this = $(this);
                 
                        if (ctrlIdx === 0) {
                          $this.children('span').addClass('open');
                          $this.children('ul').removeClass('visuallyhidden');
                        } else {
                          $this.children('span').removeClass('open');
                          $this.children('ul').addClass('visuallyhidden');
                        } 
                    });
                };
        
                $parentNodes.closest('div.inner').append($controls);
                $('ul.tree-controls a').each(function (idx) {
                    $(this).on('click', function () {
                        effectAll(idx);
                        return false;
                    });
                });
            }
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
                $mask = $('#mask'),
                loader = '<img src="" alt="Content is loading" class="loader" />',
                htmlContent;

            htmlContent = $("[data-popup=" + $linkElm.data('popup-ref') + "]").html();
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
            
            $mask.on('click', function () {
                  $popup.fadeOut(400, function(){
                    $mask.slideUp('fast', function() { $(this).remove(); $popup.remove(); });
                  });

                  $linkElm.focus();
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

            $popup.css({
              'left': ($(document).width() - $popup.innerWidth()) / 2 + 'px',
              'top': $(document).scrollTop() + 12 + 'px' 
            });
        },
        /**
          @name GOVUK.tariff.tablePopup.initialize
          @function
          @description initializes the popup behaviour
        */
        initialize : function () {
            var that = this,
                $linkElm = $('table td a.reference');

            $linkElm.attr('title', 'Opens in a popup');
            $linkElm.on('click', function (e) {
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

            // if form has already been initialised, quit
            if ($form.find('a').length) {
                return;
            }

            $input.datepicker({
                dateFormat : 'dd/mm/yy',
                maxDate: "+0m +0w"
            });

            // datepicker is allowing clicks on date anchors to pass through so prevent this
            $('#ui-datepicker-div').on('click', function (e) {
                return false;
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
    }
};
