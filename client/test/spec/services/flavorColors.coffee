'use strict'

describe 'Service: flavorColors', () ->

  # load the service's module
  beforeEach module 'dramsyApp'

  # instantiate service
  flavorColors = {}
  beforeEach inject (_flavorColors_) ->
    flavorColors = _flavorColors_

  it 'should do something', () ->
    expect(!!flavorColors).toBe true
