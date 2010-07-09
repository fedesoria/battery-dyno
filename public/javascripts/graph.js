$(function () {
  
    // first correct the timestamps - they are recorded as the daily
    // midnights in UTC+0100, but Flot always displays dates in UTC
    // so we have to add one hour to hit the midnights in the plot
    for (var i = 0; i < d.length; ++i)
      {
        d[i][0] += 60 * 60 * 1000;
        dd[i][0] += 60 * 60 * 1000;
      }

    // helper for returning the weekends in a period
    // function weekendAreas(axes) {
    //     var markings = [];
    //     var d = new Date(axes.xaxis.min);
    //     // go to the first Saturday
    //     d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
    //     d.setUTCSeconds(0);
    //     d.setUTCMinutes(0);
    //     d.setUTCHours(0);
    //     var i = d.getTime();
    //     do {
    //         // when we don't set yaxis, the rectangle automatically
    //         // extends to infinity upwards and downwards
    //         markings.push({ xaxis: { from: i, to: i + 2 * 24 * 60 * 60 * 1000 } });
    //         i += 7 * 24 * 60 * 60 * 1000;
    //     } while (i < axes.xaxis.max);
    // 
    //     return markings;
    // }
    
    // threshold: { below: "1", color: "rgba(0, 135, 0, 0.7)" },
    // grid: { markings: weekendAreas }
    
    var options =  {
        

        
        colors: ["rgba(100, 100, 100, 0.7)","rgba(100,255, 50,0.7)"],
        xaxis: { mode: "time" },
        selection: { mode: "x", color: "rgba(0, 0, 0, 0.3)" }
        
      };
    
    
      var options2 =  {


          colors: ["rgba(100, 100, 100, 0.7)","rgba(100,255, 50,0.7)"],
          xaxis: { mode: "time" },
          selection: { mode: "x", color: "rgba(0, 0, 0, 0.3)" }

        };
    // var plot = $.plot($("#placeholder"), [ dd,d], options);
    var plot = $.plot($("#placeholder"), [

      {
        data: dd,
        label: "dynos used",
        lines: {show:true, fill:true, steps: true}
      },
      {
        data: d,
        label: "requests",
        lines: { show:true, fill:true, steps: false}
      }
      
      ], options2);
    
    var overview = $.plot($("#overview"),   [

        {
          data: dd,
          lines: {show:true, fill:true, steps: true}
        },
        {
          data: d,
          lines: { show:true, fill:true, steps: false}
        }

        ], {
        series: {
            lines: { show: true, lineWidth: 1 },
            shadowSize: 0
        },
        colors: ["rgba(100, 100, 100, 0.7)","rgba(100,255, 50,0.7)"],
        xaxis: { ticks: [], mode: "time" },
        yaxis: { ticks: [], min: 0, autoscaleMargin: 0.1 },
        selection: { mode: "x", color: "rgba(0, 0, 0, 0.3)" }
    });

    // now connect the two
    
    $("#placeholder").bind("plotselected", function (event, ranges) {
        // do the zooming
        plot = $.plot($("#placeholder"), [

          {
            data: dd,
            label: "dynos used",
            lines: {show:true, fill:true, steps: true}
          },
          {
            data: d,
            label: "requests",
            lines: { show:true, fill:true, steps: false}
          }

          ],
                      $.extend(true, {}, options, {
                          xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to }
                      }));

        // don't fire event on the overview to prevent eternal loop
        overview.setSelection(ranges, true);
    });
    
    $("#overview").bind("plotselected", function (event, ranges) {
        plot.setSelection(ranges);
    });
});