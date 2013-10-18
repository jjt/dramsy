'use strict'

describe 'Directive: testo', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<testo></testo>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the testo directive'
