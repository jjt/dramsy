'use strict'

describe 'Service: profileCreator', () ->

  # load the service's module
  beforeEach module 'dramsyApp'

  # instantiate service
  profileCreator = {}
  beforeEach inject (_profileCreator_) ->
    profileCreator = _profileCreator_

  it 'should do something', () ->
    expect(!!profileCreator).toBe true
