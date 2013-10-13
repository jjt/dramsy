'use strict'

describe 'Controller: MainCtrl', () ->

  # load the controller's module
  beforeEach module 'dramsyApp'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'should just be an index for now', () ->
    expect(true).toBe true
