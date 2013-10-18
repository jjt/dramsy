'use strict'

describe 'Controller: WhiskyDetailCtrl', () ->

  # load the controller's module
  beforeEach module 'dramsyApp'

  WhiskydetailCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    WhiskyDetailCtrl = $controller 'WhiskyDetailCtrl', {
      $scope: scope
    }

  it 'should return true', () ->
    true
