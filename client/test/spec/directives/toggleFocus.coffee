'use strict'

describe 'Directive: toggleFocus', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<toggle-focus></toggle-focus>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the toggleFocus directive'
