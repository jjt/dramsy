'use strict'

ngqs = (el, selector) ->
  angular.element el.querySelector selector

angular.module('dramsyApp')
  .directive 'toggleFocus', () ->
    restrict: "A"
    scope:
      toggleFocus: "="
    compile: (element, attrs, trans) ->
      el = element[0]
      labelEl = ngqs el, '[tf-label]'
      displayEl = ngqs el, '[tf-display]'
      inputEl = ngqs el, '[tf-input]'
      inputContEl = ngqs el, '[tf-input-cont]'
      
      # If we don't have an input container, the input is its own container
      if not inputContEl[0]?
        inputContEl = inputEl
        inputEl.attr 'tf-input-cont', ''
      
      # Use built-in ng directives to wire it all up 

      # Show input on editing
      inputContEl.attr
        'ng-show': 'editing'

      # Hide display element when editing; set editing on click
      displayEl.attr
        'ng-hide': 'editing'
        'ng-click': 'editing = true'

      # Set editing on click
      labelEl.attr
        'ng-click': 'editing = true'

      # If tf-display has a value, it's the contents of innerHTML
      # Lets us have pre and post strings surrounding the model binding 
      #  ex. "In (tf-model) years"  >> "In {{ toggleFocus }} years"
      dispStr = displayEl.attr('tf-display') || '(tf-model)'
      displayEl.html dispStr.replace '(tf-model)', '{{ toggleFocus }}'

      # Wire up the input element
      inputEl.attr
        'ng-blur': 'editing = false'
        'ng-model': 'toggleFocus'
        'ng-keypress': 'setEditingFalse($event)'
        'focus': 'editing' # Focus directive


      link = (scope, element, attrs) ->
        scope.setEditingFalse = (ev) ->
          if ev.keyCode == 13 && ev.srcElement.tagName == "INPUT"
            scope.editing = false
