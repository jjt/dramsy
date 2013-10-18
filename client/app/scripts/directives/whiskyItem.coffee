'use strict'

angular.module('dramsyApp')
  .directive('whiskyItem', (whisky) ->
    template: '<div></div>'
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.text 'arsta'
  )
