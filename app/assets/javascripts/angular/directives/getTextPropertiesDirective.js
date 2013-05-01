(function(angular) {
  'use strict';

  angular.module('calcentral.directives').directive('ccGetTextProperties',  function() {

    return {
      restrict: 'A',
      scope: true,
      link: function(scope, element) {
        console.log(element);
        scope.fontName = window.getComputedStyle(element[0], null).getPropertyValue("font-family");
        scope.fontSize = window.getComputedStyle(element[0], null).getPropertyValue("font-size");

      },
      template: '<p class="panel">{{fontName}} {{fontSize}}</p>'

    };
  });

})(window.angular);
