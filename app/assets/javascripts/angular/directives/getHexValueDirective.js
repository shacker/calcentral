(function(angular) {
  'use strict';

  angular.module('calcentral.directives').directive('ccGetHexValue',  function() {

    // GetComputedStyle returns rgb, but we want to display hex values.
    // This value should end up being the same as the original SASS color var.
    var rgbToHex = function(r, g, b) {
      return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
    };

    // Automatically select contrasting foreground text color
    var darkOrLight = function(red, green, blue) {
      var brightness = (red * 299) + (green * 587) + (blue * 114);
      brightness = brightness / 255000;

      // Values range from 0 to 1. Less than 0.6 should be dark enough for light text.
      if (brightness <= 0.6) {
        return true;
      }
    };

    return {

      restrict: 'A',
      scope: true,
      link: function(scope, element, attrs) {
        setTimeout(function(){ // Without timeout, value will always be page background color!
          var rgb = window.getComputedStyle(element[0], null).getPropertyValue("background-color");
          var rgbArr = rgb.replace('rgb(','').replace(')','').split(",");
          var red = parseInt(rgbArr[0], 10);
          var green = parseInt(rgbArr[1], 10);
          var blue = parseInt(rgbArr[2], 10);
          scope.className = attrs.ccGetHexValue;
          scope.hexVal = rgbToHex(red, green, blue);
          scope.lightText = darkOrLight(red, green, blue);
        }, 0);

      },
      template: '<p data-ng-class="{true:\'cc-light-text\'}[lightText]">{{className}}<br />{{hexVal}}</p>'

    };
  });

})(window.angular);
