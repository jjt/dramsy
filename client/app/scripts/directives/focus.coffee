'use strict'

angular.module('dramsyApp')
  .directive 'focus', ($timeout) ->
    (scope, el, attrs) ->
      scope.$watch attrs.focus, (newVal) ->
        if newVal == true
          $timeout () ->
            el[0].focus()
          
