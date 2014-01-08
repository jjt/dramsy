'use strict'

angular.module('dramsyApp')
  .controller 'WhiskyDetailCtrl', ($scope, $timeout, whisky, whiskyAll) ->
    $scope.whisky = if whisky == 'null' then {} else {}
    $scope.whiskyAll = whiskyAll
    $scope.whisky.isNew = not whisky._id?
    $scope.whisky.flavors ?= [0,0,0,0,0,0,0,0]
     
    $scope.isFormClean = () ->
      $scope.whiskyForm.$pristine == true
    
    $scope.fwUpdateFn = (index, rating) ->
      if $scope.whisky.flavors[index] != rating
        $timeout $scope.whiskyForm.$setDirty, 0
      $scope.whisky.flavors[index] = rating

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

    $scope.delete = () ->
      $scope.whis
