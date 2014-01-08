'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyCtrl', ($scope, flavorColors, localStorageService) ->
    $scope.whiskies = [{}]
    $scope.flavorColors = flavorColors
