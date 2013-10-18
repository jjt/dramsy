'use strict'

angular.module('dramsyApp')
  .directive 'focusInput', () ->
    restrict: "A"
    templateUrl: '/views/focusInput.html'
    scope:
      focusInput: "="
      fiInput: "@"
      fiLabel: "@"
      fiInputClass: "@"
      fiInputType: "@"
    compile: (el, attrs, trans) ->
      attrs.fiInput ?= 'input'
      attrs.fiInputType ?= 'text'
      
      elHTML = el[0].innerHTML.replace 'inputtagname', attrs.fiInput
      el.html elHTML

      (scope, element, attrs) ->
        element.addClass 'FocusInput form-group'
        label = angular.element element.children()[0]
        span = angular.element element.children()[1]

        if attrs.fiLabel
          span.addClass 'col-lg-10'
        else
          label.remove()

        # Bind the enter event to a blur
        input = angular.element element[0].querySelectorAll('[inputElement]')[0]
        input.attr 'type', attrs.fiInputType
        if attrs.fiInput == 'input'
          input.bind 'keypress', (e) ->
            if e.keyCode == 13 or e.keyIdentifier == "Enter"
              scope.editing = false
