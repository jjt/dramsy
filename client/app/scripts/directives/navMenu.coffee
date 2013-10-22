'use strict'

angular.module('dramsyApp')
  .directive "navMenu", ($location) ->
    (scope, element, attrs) ->
      links = element.find("a")
      onClass = attrs.navMenu or "on"
      routePattern = /^#[^/]*/  unless $location.$$html5
      currentLink = undefined
      urlMap = {}

      for link in links
        linkEl = angular.element(link)
        url = linkEl.attr("href")
        if $location.$$html5
          urlMap[url] = linkEl
        else
          urlMap[url.replace(routePattern, "")] = linkEl

      scope.$on "$routeChangeStart", ->
        pathLink = urlMap[$location.path()]
        if pathLink
          currentLink.parent().removeClass onClass  if currentLink
          currentLink = pathLink
          currentLink.parent().addClass onClass
