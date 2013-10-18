'use strict'

angular.module('dramsyApp')
  .directive 'focusMe', () ->
    (scope, el, attrs) ->
      attrs.$observe 'focusMe', (val) ->
        console.log 'arsta'
        el[0].focus()
