'use strict'

describe 'Directive: navMenu', () ->

  # load the directive's module
  beforeEach module 'dramsyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<nav-menu></nav-menu>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the navMenu directive'
