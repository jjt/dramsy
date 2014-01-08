'use strict'

describe 'Service: loginService', () ->

  # load the service's module
  beforeEach module 'dramsyApp'

  # instantiate service
  loginService = {}
  beforeEach inject (_loginService_) ->
    loginService = _loginService_

  it 'should do something', () ->
    expect(!!loginService).toBe true
