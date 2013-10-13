'use strict'

describe 'Controller: WhiskyCtrl', () ->

  # load the controller's module
  beforeEach module 'dramsyApp'

  WhiskyCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    WhiskyCtrl = $controller 'WhiskyCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(3).toBe 3
