'use strict'

angular.module('dramsyApp')
  .directive 'flavourWheel', () ->
    templateUrl: '/views/flavourWheel.html'
    restrict: 'AE'
    scope:
      fwData: '='
      
    compile: (element, attrs, trans) ->

      flavours = ['Wood', 'Cereal', 'Fruit', 'Wine', 'Floral', 'Feinty',
        'Sulphur', 'Peat']
      colors = ['#765825', '#c89700', '#DC322F', '#b83074', '#6C71C4',
        '#268BD2', '#888', '#859900']

      maxRating = 5
      numSegs = flavours.length
      segmentBg = '#eee'

      darker = (color, amt = 0.3) ->
        d3.rgb(color).darker(amt)

      flavoursToCircChart = (ratings) ->
        numOutput = maxRating * numSegs
        out = []
        i = 0
        while i < numOutput
          segOn = ratings[i % numSegs] > Math.floor i/numSegs
          out[i] = if segOn then 100 else 0
          i++
        out
        
      link = (scope, element, attrs) ->
        segmentHeight = 26
        exampleRatings = (_.random(0,5) for flavour in flavours)
        ratings = scope.fwData || exampleRatings
        ratings = flavoursToCircChart ratings
        element.addClass 'flavour-wheel'
        

        addCenterTextEls = (el) ->
          el.append('text')
          textEl = el.select('text')
          textEl.append('tspan')
            .attr(dy: '1.2em', x: 0, class: 'label-style')
            .text('Flavor')
          textEl.append('tspan')
            .attr(dy: '1.2em', x: 4, class: 'label-style')
            .text('Wheel')

        segmentClick = () ->
            seg = d3.select this
            segId = 1 * seg.attr 'seg-id'
            newRating = 1 + 1 * seg.attr 'radial-id'

            # If current rating == newRating == 1, set rating to 0 
            if newRating == 1 and scope.fwData[segId] == 1
              newRating = 0
              
            
            # I'd like a better way to do this... 
            if scope.$parent.fwUpdateFn
              scope.$parent.fwUpdateFn segId, newRating
              
            #scope.fwData[segId] = newRating

            ratings = flavoursToCircChart scope.fwData
            # Update cells in this segment by setting their fill
            # Should probably figure out a more idiomatic d3 way
            i = maxRating
            while i--
              cellId = i * numSegs + segId
              newColor = if newRating > i then colors[segId] else segmentBg
              newStroke = darker newColor, 0.2
              darkerColor = darker newColor, 0.3
              darkerStroke = darker darkerColor, 0.2
                
              d = d3.select("[cell-id='#{cellId}']")
              # Set colors, check to see if we're moused over the cell
              d.attr
                'fill': if d.attr('mouseover') then darkerColor else newColor
                'stroke': if d.attr('mouseover') then darkerStroke else newStroke
                'fill-orig': newColor
                'stroke-orig': newStroke
          

        chart = circularHeatChart()
          .segmentHeight(segmentHeight)
          .margin(top: 30, right: 30, bottom: 30, left:30)
          .domain([0,100])
          .innerRadius(44)
          .numSegments(numSegs)
          .segmentLabels(flavours)
          .segmentColors(colors)
          .segmentBg(segmentBg)
          .segmentMargin(0.8)
          .addCenterTextEls(addCenterTextEls)
          .segmentClick(segmentClick)
          .segmentMouseover () ->
            d = d3.select this
            d.attr
              'fill-orig': d.attr('fill')
              'fill': darker d.attr('fill')
              'stroke-orig': d.attr('stroke')
              'stroke': darker darker d.attr('stroke'), 0.2
              'mouseover': true
          .segmentMouseout () ->
            d = d3.select this
            d.attr
              'fill': d.attr('fill-orig')
              'stroke': d.attr('stroke-orig')
              'mouseover': null
            
        showChart = (chart) ->
          d3.select(element.find('svg-holder')[0])
            .selectAll('svg')
            .data([ratings])
            .enter()
            .append('svg')
            .call(chart)

        showChart(chart)
