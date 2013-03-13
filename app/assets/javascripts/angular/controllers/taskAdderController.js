(function(calcentral) {

  'use strict';

  /**
   * Task adder controller
   */
  calcentral.controller('TaskAdderController', ['$http', '$scope', 'apiService', function($http, $scope, apiService) {
    $scope.show_add_task = false;
    $scope.add_edit_task = {};

    $scope.addTaskCompleted = function(data) {
      $scope.add_edit_task = {};
      $scope.task_adder_is_processing = false;
      $scope.show_add_task = false;
      $scope.tasks.push(data);
    };

    $scope.addTask = function() {

      var trackEvent = 'notes: ' + !!$scope.add_edit_task.notes + ' date: ' + !!$scope.add_edit_task.due_date;
      apiService.analytics.trackEvent(['Tasks', 'Add', trackEvent]);
      // When the user submits the task, we show a processing message
      // This message will disappear as soon the task has been added.
      $scope.task_adder_is_processing = true;

      // Date picker settings
      $scope.dateOptions = {
        changeYear: true,
        changeMonth: true,
        yearRange: '2013:2020'
      };

      var newtask = {
        'emitter': 'Google',
        'notes': $scope.add_edit_task.notes,
        'title': $scope.add_edit_task.title
      };

      // Not all tasks have dates.
      if ($scope.add_edit_task.due_date) {
        var submitDate = $scope.add_edit_task.due_date;
        newtask.due_date = submitDate.getFullYear() + '-' + (submitDate.getMonth() + 1) + '-' + submitDate.getDate();
      }

      // Angular already blocks form submission if title is empty, but also check here for testing
      if (newtask.title) {
        $http.post('/api/my/tasks/create', newtask).success($scope.addTaskCompleted);
      }
    };

    $scope.toggleAddTask = function() {
      $scope.show_add_task = !$scope.show_add_task;
      apiService.analytics.trackEvent(['Tasks', 'Add panel - ' + $scope.show_add_task ? 'Show' : 'Hide']);
    };

  }]);

})(window.calcentral, window.angular);
