'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyDetailCtrl', ($scope, Restangular, whisky, whiskyAll) ->
    $scope.whisky = if whisky == 'null' then {} else Restangular.copy whisky
    $scope.whiskyAll = whiskyAll
    $scope.whisky.isNew = not whisky._id?
    $scope.whisky.flavors ?= [0,0,0,0,0,0,0,0]
     
    $scope.cleanForm = () ->
      $scope.whiskyForm.$pristine == true
    
    $scope.save = () ->
      if whisky._id?
        $scope.whisky.put().then () ->
          $scope.whisky.clean = true
          $scope.whiskyForm.$setPristine()
          alert 'saved!'
      else
        $scope.whiskyAll.post($scope.whisky).then () ->
          console.log arguments
          alert 'created!'
