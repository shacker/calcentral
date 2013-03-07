(function(calcentral) {

  'use strict';

  /**
   * Task editor controller
   */
  calcentral.controller('TaskEditorController', ['$http', '$scope', 'apiService', function($http, $scope, apiService) {

    $scope.editorEnabled = false;

    $scope.enableEditor = function() {
      $scope.editorEnabled = true;
      $scope.task.show = false; // Otherwise the form is on blue "show" background.
      // Shift the scope to match scope of the add_task form
      $scope.add_edit_task = {
        'title': $scope.task.title,
        'due_date': $scope.task.due_date,
        'note': $scope.task.note
      };

      // We don't store the exact date format they entered originally, so reconstruct from epoch
      if ($scope.task.due_date) {
        var d = new Date($scope.task.due_date.epoch * 1000);
        var mm = ('0' + (d.getMonth() + 1)).slice(-2);
        var dd = ('0' + d.getDate()).slice(-2);
        var yy = String(d.getFullYear()).slice(-2);
        $scope.add_edit_task.due_date = mm + '/' + dd + '/' + yy;
      }
    };

    $scope.disableEditor = function() {
      $scope.editorEnabled = false;
    };

    $scope.editTaskCompleted = function(data) {
      angular.extend($scope.task, data);
    };

    $scope.editTask = function(task) {
      var changedTask = angular.copy(task); // Start with a copy of the task (with ID, etc.) and override these props
      changedTask.title = $scope.add_edit_task.title;
      changedTask.note = $scope.add_edit_task.note;

      // Not all tasks have dates.
      if ($scope.add_edit_task.due_date) {
        changedTask.due_date = {};
        var newdatearr = $scope.add_edit_task.due_date.split(/[\/\.\- ]/);
        changedTask.due_date.datetime = 20 + newdatearr[2] + '-' + newdatearr[0] + '-' + newdatearr[1];
      }

      apiService.analytics.trackEvent(['Tasks', 'Task edited', 'edited: ' + !!changedTask.title]);
      $http.post('/api/my/tasks', changedTask).success($scope.editTaskCompleted)
        .error(function() {
          apiService.analytics.trackEvent(['Error', 'Task editing failure', 'edited: ' + !!changedTask.title]);
          //Some error notification would be helpful.
      });

      $scope.disableEditor();

    };
  }]);

})(window.calcentral, window.angular);
