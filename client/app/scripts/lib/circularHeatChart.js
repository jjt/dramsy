function circularHeatChart() {
  var margin = {top: 20, right: 20, bottom: 20, left: 20},
      innerRadius = 50,
      numSegments = 24,
      segmentHeight = 20,
      domain = null,
      range = ['white', 'red'],
      svgBg = null, 
      segmentColors = [],
      segmentLabelColor = 'black',
      segmentBg = 'white',
      segmentMargin = 0,
      accessor = function(d) {return d;},
      segmentClick = null,
      segmentMouseover = null,
      segmentMouseout = null,
      radialLabels = segmentLabels = [];

  // These local vars will be turned into getter/setters
  var getterSetters = ['margin', 'innerRadius', 'numSegments', 'segmentHeight',
    'domain', 'range', 'radialLabels', 'svgBg', 'segmentLabels',
    'segmentColors', 'segmentBg', 'segmentClick', 'segmentMouseover', 
    'segmentMouseout', 'segmentMargin', 'accessor']

  function chart(selection) {
    console.log(selection);
    selection.each(function(data) {
      var svg = d3.select(this);

      var offset = innerRadius + Math.ceil(data.length / numSegments) * segmentHeight;
      var circHeatTranslate = 'translate(' + parseInt(margin.left + offset) + ',' + parseInt(margin.top + offset) + ')'

      var bgArc = d3.svg.arc()
        .innerRadius(0)
        .startAngle(0)
        .endAngle(360);

      svg.append('g')
        .append('path')
        .attr('d', bgArc.outerRadius(innerRadius+1))
        .attr('transform', circHeatTranslate)
        .classed('ch-center', true)

      g = svg
        .attr('style', function() { if(svgBg) return 'background-color: ' + svgBg })
        .append('g')
        .classed('circular-heat', true)
        .attr('transform', circHeatTranslate);


      var autoDomain = false;
      if (domain === null) {
        domain = d3.extent(data, accessor);
        autoDomain = true;
      }
      var colorRangeDomainObj = d3.scale.linear().domain(domain);
      if(autoDomain)
        domain = null;

      var cellColorFn = function(d, i) {
        var colorRange = range;
        if(segmentColors.length)
          colorRange = [segmentBg, segmentColors[i % numSegments]];
        return colorRangeDomainObj.range(colorRange)(accessor(d));
      }
      g.selectAll('path').data(data)
        .enter().append('path')
        .attr('d', d3.svg.arc().innerRadius(ir).outerRadius(or).startAngle(sa).endAngle(ea))
        .attr('cell-id', function(d, i) { return i; })
        .attr('seg-id', function(d, i) { return i % numSegments; })
        .attr('radial-id', function(d, i) { return Math.floor(i / numSegments); })
        .attr('fill', cellColorFn)
        .attr('stroke', cellColorFn)
        .on('click', segmentClick)
        .on('mouseover', segmentMouseover)
        .on('mouseout', segmentMouseout)


      // Unique id so that the text path defs are unique - is there a better way to do this?
      var id = d3.selectAll('.circular-heat')[0].length;

      //Radial labels
      var lsa = 0.01; //Label start angle
      var labels = svg.append('g')
        .classed('labels', true)
        .classed('radial', true)
        .attr('transform', circHeatTranslate)

      labels.selectAll('def')
        .data(radialLabels).enter()
        .append('def')
        .append('path')
        .attr('id', function(d, i) {return 'radial-label-path-'+id+'-'+i;})
        .attr('d', function(d, i) {
          var r = innerRadius + ((i + 0.2) * segmentHeight);
          return 'm' + r * Math.sin(lsa) + ' -' + r * Math.cos(lsa) + 
          ' a' + r + ' ' + r + ' 0 1 1 -1 0';
        });

      labels.selectAll('text')
        .data(radialLabels).enter()
        .append('text')
        .append('textPath')
        .attr('xlink:href', function(d, i) {return '#radial-label-path-'+id+'-'+i;})
        .style('font-size', 0.6 * segmentHeight + 'px')
        .text(function(d) {return d;});

      //Segment labels
      var segmentLabelOffset = 2;
      var r = innerRadius + Math.ceil(data.length / numSegments) * segmentHeight + segmentLabelOffset;
      var circumference = 2 * Math.PI * r;
      var segArcLen = circumference / numSegments;

      labels = svg.append('g')
        .classed('labels', true)
        .classed('segment', true)
        .attr('transform', circHeatTranslate);

      r += 6;

      labels.append('def')
        .append('path')
        .attr('id', 'segment-label-path-'+id)
        .attr('d', 'm0 -' + r + ' a' + r + ' ' + r + ' 0 1 1 -1 0');

      labels.selectAll('text')
        .data(segmentLabels).enter()
        .append('text')
        .attr('style', function(d, i) {
          if(segmentColors)
            return 'fill: ' + segmentColors[i];
          return 'fill: ' + segmentLabelColor;
        })
        .attr('class', 'label-style')
        .append('textPath')
        .attr('xlink:href', '#segment-label-path-'+id)
        .text(function(d, i) {
          return d;
        })
        .attr('startOffset', function(d, i) {
          // Centered text labels
          var fudgePct = 100 * (segArcLen - this.textLength.baseVal.value) /
            (circumference * 2);
          return (i * 100 / numSegments) + fudgePct + '%';
        });

    });
  }

  /* Arc functions */
  ir = function(d, i) {
    return innerRadius + Math.floor(i/numSegments) * segmentHeight;
  }
  or = function(d, i) {
    return innerRadius + segmentHeight + Math.floor(i/numSegments) * segmentHeight;
  }
  sa = function(d, i) {
    return (i * 2 * Math.PI + segmentMargin) / numSegments;
  }
  ea = function(d, i) {
    return ((i + 1) * 2 * Math.PI - segmentMargin) / numSegments;
  }


  // Getter/setters
  //
  // circularHeatchart uses local variables as members, so we have to use
  // eval in order to get/set them
  getterSetters.forEach(function(gS) {
      chart[gS] = function(_) {
        if (!arguments.length) {
          eval('var retVal = ' + gS);  
          return retVal;
        }
        eval('' + gS + ' = _');
        return chart;
      }
  });

  return chart;
}
