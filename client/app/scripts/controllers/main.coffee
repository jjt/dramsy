'use strict'

angular.module('dramsyApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.whiskies = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
