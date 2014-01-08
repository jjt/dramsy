'use strict'

errMsg = (err) ->
  (if err then "[" + err.code + "] " + err.toString() else null)

facFn = (angularFireAuth, profileCreator, $location, $rootScope) ->
  ###
  @param {string} email
  @param {string} pass
  @param {string} [redirect]
  @param {Function} [callback]
  @returns {*}
  ###
  login: (email, pass, redirect, callback) ->
    p = angularFireAuth.login("password",
      email: email
      password: pass
      rememberMe: true
    )
    p.then ((user) ->
      $location.path redirect  if redirect
      callback and callback(null, user)
    ), callback

  
  ###
  @param {string} [redirectPath]
  ###
  logout: (redirectPath) ->
    angularFireAuth.logout()
    $location.path redirectPath  if redirectPath

  changePassword: (opts) ->
    if not opts.oldpass or not opts.newpass
      opts.callback "Please enter a password"
    else if opts.newpass isnt opts.confirm
      opts.callback "Passwords do not match"
    else
      angularFireAuth._authClient.changePassword opts.email, opts.oldpass, opts.newpass, (err) ->
        opts.callback errMsg(err)
        $rootScope.$apply()


  createAccount: (email, pass, callback) ->
    angularFireAuth._authClient.createUser email, pass, (err, user) ->
      if callback
        callback err, user
        $rootScope.$apply()

  createProfile: profileCreator

angular.module('dramsyApp')
 .factory "loginService", ["angularFireAuth", "profileCreator", "$location", "$rootScope", facFn]
 
