'use strict'

fn = (flavorColors) ->
  template: '<div></div>'
  scope:
    unispark: '='
  restrict: 'EA'
  link: (scope, element, attrs) ->
    ratings = for rating, index in scope.unispark
      color = flavorColors[index]
      charcode = 2581
      if rating > 0
        charcode += rating + 1
      "<span style=\"color:#{color}\">&#x#{charcode};</span>"
      
    element.html(ratings.join(''))
      .addClass('unispark')


angular.module('dramsyApp')
  .directive 'unispark', ['flavorColors', fn]
