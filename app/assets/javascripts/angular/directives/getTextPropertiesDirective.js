(function(angular) {
  'use strict';

  angular.module('calcentral.directives').directive('ccGetTextProperties',  function() {

    return {
      restrict: 'A',
      scope: true,
      link: function(scope, element) {
        var fontName = window.getComputedStyle(element[0], null).getPropertyValue("font-family");
        var fontSize = window.getComputedStyle(element[0], null).getPropertyValue("font-size");
        element.after("<div class=\"panel\">" + fontSize + fontName + "</div>");
      }
    };
  });

})(window.angular);
