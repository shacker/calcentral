(function(angular) {
  'use strict';

  angular.module('calcentral.directives').directive('ccGetHexValue', function() {

    return {
        restrict: 'A',
        link: function(scope) {
          console.log(scope);
        }
    };
  });

})(window.angular);
