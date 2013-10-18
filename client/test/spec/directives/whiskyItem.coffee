'use strict'

describe 'Directive: whiskyItem', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<whisky-item></whisky-item>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the whiskyItem directive'
