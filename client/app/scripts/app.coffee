'use strict'

angular.module('dramsyApp', ['restangular', 'ngRoute'])
  .config ($routeProvider, $locationProvider, RestangularProvider, rootUrlApi) ->
    $routeProvider
      .when '/',
        templateUrl: '/views/main.html'
        controller: 'MainCtrl'
      .when '/tasting',
        templateUrl: '/views/whisky.html'
        controller: 'WhiskyCtrl'
      .when '/tasting/new',
        controller: 'WhiskyDetailCtrl'
        templateUrl: '/views/whiskyDetail.html'
        resolve:
          whisky: () ->
            {}
          whiskyAll: (Restangular) ->
            Restangular.all('whisky')

      .when '/tasting/:id',
        controller: 'WhiskyDetailCtrl'
        templateUrl: '/views/whiskyDetail.html'
        resolve:
          whisky: (Restangular, $route) ->
            Restangular.one('whisky', $route.current.params.id).get()
          whiskyAll: (Restangular) ->
            Restangular.all('whisky')
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true

    portStr = ''
    if window.location.port != ''
      portStr = ":#{window.location.port}"
    RestangularProvider.setBaseUrl "http://#{window.location.hostname}#{portStr}/api/"
    RestangularProvider.setRestangularFields id: '_id'

