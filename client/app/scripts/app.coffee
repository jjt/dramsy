'use strict'

angular.module('dramsyApp', ['restangular', 'ngRoute'])
  .config ($routeProvider, RestangularProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/whisky',
        templateUrl: 'views/whisky.html'
        controller: 'WhiskyCtrl'
      .when '/whisky/:id',
        controller: 'WhiskyDetailCtrl'
        templateUrl: 'views/whiskyDetail.html'
        resolve:
          whisky: (Restangular, $route) ->
            Restangular.one('whisky', $route.current.params.id).get()
      .otherwise
        redirectTo: '/'

    RestangularProvider.setBaseUrl 'http://dramsy.node/api/'
    RestangularProvider.setRestangularFields id: '_id'

