'use strict'

describe 'Service: whisky', () ->

  # load the service's module
  beforeEach module 'dramsyApp'

  # instantiate service
  whisky = {}
  beforeEach inject (_whisky_) ->
    whisky = _whisky_

  it 'should do something', () ->
    expect(!!whisky).toBe true
