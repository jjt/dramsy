angular.module('dramsyApp').directive "editspan", ->
  restrict: "E"
  template: "<div>
    <span ng-hide=\"editing\" ng-class=\"spanClass\">{{text}}</span>
    <input type=\"text\" ng-class=\"inputClass\"></div>"
  scope:
    text: "=model"
    onReady: "&"
    spanClass: "@"
    inputClass: "@"

  replace: true
  link: (scope, element, attrs) ->
    startEdit = ->
      bindEditElements()
      setEdit true
      input[0].focus()
    bindEditElements = ->
      input.bind "blur", ->
        stopEdit()

      input.bind "keyup", (event) ->
        stopEdit()  if isEscape(event)

      form.bind "submit", ->
        
        # you can't save empty string
        save()  if input[0].value
        stopEdit()

    save = ->
      scope.text = input[0].value
      scope.$apply()
      scope.onReady()
    stopEdit = ->
      unbindEditElements()
      setEdit false
    unbindEditElements = ->
      input.unbind()
      form.unbind()
    setEdit = (value) ->
      scope.editing = value
      scope.$apply()
    isEscape = (event) ->
      event and event.keyCode is 27
    span = angular.element(element.children()[0])
    form = angular.element(element.children()[1])
    input = angular.element(element.children()[1][0])
    span.bind "click", (event) ->
      input[0].value = scope.text
      startEdit()
