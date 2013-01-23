(function(calcentral) {
  'use strict';

  /**
   * Dashboard controller
   */
  calcentral.controller('DashboardController', ['$rootScope', function($rootScope) {

    $rootScope.title = 'Dashboard | CalCentral';

    $rootScope.show_dropdown = false; // For settings menu dropdown

    $rootScope.toggleDropDown = function(){
      $rootScope.show_dropdown = !$rootScope.show_dropdown;
    };


  }]);

})(window.calcentral);
