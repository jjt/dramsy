'use strict'

describe 'Directive: focusInput', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<focus-input></focus-input>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the focusInput directive'
