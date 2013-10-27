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
      colors = ['#765825', '#b5891d', '#DC322F', '#D33682', '#6C71C4',
        '#268BD2', '#888', '#859900']

      maxRating = 5
      numSegs = flavours.length
      segmentBg = '#eee'

      darker = (color) ->
        d3.rgb(color).darker(0.3)

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
        
        showChart = (chart) ->
          d3.select(element.find('svg-holder')[0])
            .selectAll('svg')
            .data([ratings])
            .enter()
            .append('svg')
            .call(chart)

        segmentClick = () ->
            seg = d3.select this
            segId = 1 * seg.attr 'seg-id'
            newRating = 1 + 1 * seg.attr 'radial-id'
            ratings = flavoursToCircChart scope.fwData
            console.log('click', scope.fwData, this)

            # If current rating == newRating == 1, set rating to 0 
            if newRating == 1 and scope.fwData[segId] == 1
              newRating = 0
              
            scope.fwData[segId] = newRating

            # Update cells in this segment by setting their fill
            # Should probably figure out a more idiomatic d3 way
            i = maxRating
            while i--
              cellId = i * numSegs + segId
              newColor = if newRating > i then colors[segId] else segmentBg
              darkerColor = darker newColor
              console.log cellId, newColor, newRating, i, segId
                
              d = d3.select("[cell-id='#{cellId}']")
              # Set colors, check to see if we're moused over the cell
              d.attr
                'fill': if d.attr('mouseover') then darkerColor else newColor
                'stroke': if d.attr('mouseover') then darkerColor else newColor
                'fill-orig': newColor
                'stroke-orig': newColor
          

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
          .segmentClick(segmentClick)
          .segmentMouseover () ->
            d = d3.select this
            d.attr
              'fill-orig': d.attr('fill')
              'fill': darker d.attr('fill')
              'stroke-orig': d.attr('stroke')
              'stroke': darker d.attr('stroke')
              'mouseover': true
          .segmentMouseout () ->
            d = d3.select this
            d.attr
              'fill': d.attr('fill-orig')
              'stroke': d.attr('stroke-orig')
              'mouseover': null
            
        window.chart = chart
        showChart(chart)
