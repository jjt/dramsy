'use strict'

facFn = (Firebase, FBURL, $rootScope) ->
  (id, email, callback) ->
    
    #err && console.error(err);
    firstPartOfEmail = (email) ->
      ucfirst email.substr(0, email.indexOf("@")) or ""
    ucfirst = (str) ->
      
      # http://kevin.vanzonneveld.net
      # +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
      # +   bugfixed by: Onno Marsman
      # +   improved by: Brett Zamir (http://brett-zamir.me)
      # *     example 1: ucfirst('kevin van zonneveld');
      # *     returns 1: 'Kevin van zonneveld'
      str += ""
      f = str.charAt(0).toUpperCase()
      f + str.substr(1)
    new Firebase(FBURL).child("users/" + id).set
      email: email
      name: firstPartOfEmail(email)
    , (err) ->
      if callback
        callback err
        $rootScope.$apply()


angular.module('dramsyApp')
  .factory "profileCreator", ["Firebase", "FBURL", "$rootScope", facFn]
