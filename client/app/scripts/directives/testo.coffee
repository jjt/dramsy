'use strict'

angular.module('dramsyApp').directive 'testeroni', () ->
  (scope, element) ->
    element.bind "mouseenter", () ->
      console.log "msg"
