'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyDetailCtrl', ($scope, Restangular, whisky) ->
    $scope.whisky = Restangular.copy whisky

    $scope.cleanForm = () ->
      $scope.whiskyForm.$pristine == true
    
    $scope.save = () ->
      $scope.whisky.put().then () ->
        console.log arguments
        $scope.whisky.clean = true
        alert 'saved!'
         
