(function(window, angular) {

  'use strict';

  /**
   * Initialize all of the submodules
   */
  angular.module('calcentral.directives', []);
  angular.module('calcentral.services', ['ng', 'ui']);

  /**
   * CalCentral module
   */
  var calcentral = angular.module('calcentral', [
    'calcentral.directives',
    'calcentral.services',
    'ngSanitize'
  ]);

  // Set the configuration
  calcentral.config(['$httpProvider', '$locationProvider', '$routeProvider', function($httpProvider, $locationProvider, $routeProvider) {

    // We set it to html5 mode so we don't have hash bang URLs
    $locationProvider.html5Mode(true).hashPrefix('!');

    // List all the routes
    $routeProvider.when('/', {
      templateUrl: 'templates/splash.html',
      controller: 'SplashController',
      isPublic: true
    }).
    // We actually need to duplicate the campus items, more info on
    // http://stackoverflow.com/questions/12524533
    when('/campus', {
      templateUrl: 'templates/campus.html',
      controller: 'CampusController'
    }).
    when('/campus/:category', {
      templateUrl: 'templates/campus.html',
      controller: 'CampusController'
    }).
    when('/dashboard', {
      templateUrl: 'templates/dashboard.html',
      controller: 'DashboardController'
    }).
    when('/settings', {
      templateUrl: 'templates/settings.html',
      controller: 'SettingsController'
    }).

    // Redirect to a 404 page
    otherwise({
      templateUrl: 'templates/404.html',
      controller: 'ErrorController',
      isPublic: true
    });

    // Setting up CSRF tokens for POST, PUT and DELETE requests
    var document = window.document;
    var tokenElement = document.querySelector('meta[name=csrf-token]');
    if (tokenElement && tokenElement.content) {
      $httpProvider.defaults.headers.post['X-CSRF-Token'] = tokenElement.content;
      $httpProvider.defaults.headers.put['X-CSRF-Token'] = tokenElement.content;
    }

  }]);

  // Bind calcentral to the window object so it's globally accessible
  window.calcentral = calcentral;

})(window, window.angular);
