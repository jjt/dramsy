'use strict'

# Angular querySelector function
ngqs = (el, selector) ->
  angular.element el.querySelector selector

angular.module('dramsyApp')
  .directive 'toggleFocus', ($timeout) ->
    restrict: "AE"
    scope:
      toggleFocus: "="
      editMode: "@"
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

      # Any value in tf-display is a str for innerHTML, after interpolation
      # Lets us have pre and post strings surrounding the model binding 
      #  ex. "In (tf-model) years"  >> "In {{ toggleFocus }} years"
      dispStr = displayEl.attr('tf-display') || '(tf-model)'
      displayEl.html dispStr.replace '(tf-model)', '{{ toggleFocus }}'

      # Hide display element when editing; set editing on click
      displayEl.attr
        'ng-hide': 'editing || !toggleFocus'
        'ng-click': 'editing = true'

      # Make a placeholder element to display if our model is empty
      placeholderEl = displayEl.clone()
      placeholderEl.html dispStr.replace '(tf-model)', inputEl.attr('placeholder')
      placeholderEl.attr
        'ng-hide': 'toggleFocus || editing'
      placeholderEl.addClass 'placeholder'
      displayEl.after placeholderEl

      # Set editing on click
      labelEl.attr
        'ng-click': 'editing = true'

      # Wire up the input element
      inputEl.attr
        'ng-blur': 'inputBlur($event)'
        'ng-keypress': 'inputKeypress($event)'
        'ng-model': 'toggleFocus'
        'focus': 'editing' # Focus directive

      # Return link function
      link = (scope, element, attrs) ->

        if scope.editMode == 'true'
          scope.editing = true

        scope.inputBlur = (ev) ->
          console.log(ev, scope)
          if scope.editMode != 'true'
            console.log 'not in edit mode'
            scope.editing = false

        scope.inputKeypress = (ev) ->
          console.log 'scope.inputKeypress'
          if ev.keyCode == 13 && ev.srcElement.tagName == "INPUT"
            scope.editing = false
