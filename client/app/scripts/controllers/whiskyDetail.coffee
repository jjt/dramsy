'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyDetailCtrl', ($scope, Restangular, whisky) ->
    $scope.whisky = Restangular.copy whisky

    $scope.cleanForm = () ->
      $scope.whiskyForm.$pristine == true
    
    $scope.save = () ->
      $scope.whisky.put().then () ->
        $scope.whisky.clean = true
        $scope.whiskyForm.$setPristine()
        alert 'saved!'
         
