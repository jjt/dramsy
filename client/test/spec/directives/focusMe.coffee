'use strict'

describe 'Directive: focusMe', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<focus-me></focus-me>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the focusMe directive'
