'use strict'

angular.module('dramsyApp', ['restangular'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/whisky',
        templateUrl: 'views/whisky.html'
        controller: 'WhiskyCtrl'
      .otherwise
        redirectTo: '/'
