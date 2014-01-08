'use strict'

angular.module('LocalStorageModule').value('prefix', 'dramsy-tvyqa2')
angular.module('dramsyApp', ['ngRoute', 'jjt.unispark', 'LocalStorageModule'])
  .config ($routeProvider, $locationProvider, rootUrlApi) ->
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
          whiskyAll: () ->
            [{}]

      .when '/tasting/:id',
        controller: 'WhiskyDetailCtrl'
        templateUrl: '/views/whiskyDetail.html'
        resolve:
          whisky: ($route) ->
            {}
          whiskyAll: () ->
            [{}]
      .otherwise
        redirectTo: '/'


    $locationProvider.html5Mode true

    portStr = ''
    if window.location.port != ''
      portStr = ":#{window.location.port}"



#angular.module('dramsyApp')
  #.run ['angularFireAuth', 'Config', '$rootScope', (angularFireAuth, Config, $rootScope) ->
    #angularFireAuth.initialize Config.fbURL,
      #scope: $rootScope
      #name: 'auth'
      #path: '/login'
    #$rootScope.fbURL = fbURL
    #]

