'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyCtrl', ($scope, Restangular) ->
    $scope.whiskies = Restangular.all('whisky').getList()
