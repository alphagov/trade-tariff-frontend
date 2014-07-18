/**
  @name BetaPopup
  @namespace
  @description A set of methods for generating popups and related odds and ends
  @requires jquery 1.6.2
*/

var BetaPopup = {


  /**
    @name BetaPopup.popup
    @function
    @description Shows a feedback popup
    @param html A snippet of HTML to put into the popup.
    @param ident A class name to apply to the popup, so it can be uniquely styled.
    @param source A focal point to return to on close, usually the originating anchor

    @example
      BetaPopup.popup($("#myContent").html(), "myContentClass");
  */

  popup: function(html, ident, source){
    var $mask = $("<div />", {id: "mask", style: "opacity:0;"}),
        $popup = $("<div />", {id: "popup", class: ident});

    $("body").append($mask).append($popup);

    var source = source || "#header-global h1 a",
    $popup = $('#popup'), $win = $(window), $mask = $('#mask');
    $popup.append(html);

    $mask.animate({opacity: 0.6});

    //Get the window height and width
    var winH = $win.height();
    var winW = $win.width();

    //Set the popup window to center
    $popup.css('left', winW/2-$popup.width()/2);

    $popup.delay(100).fadeIn('fast', function(){
      $popup.find("h2").attr("tabindex",-1).focus();
    });
    $popup.on('keydown', function (e) {
       if ( e.which == 27 ){
           closePopup();
        }
    }).on("click", ".close", function(){
      closePopup()
      return false;
    });

    closePopup = function(){
      $popup.fadeOut(400, function(){
        $mask.fadeOut('fast', function() { $(this).remove(); $popup.remove(); });
      });

      $(source).focus();
    }
  }
};
