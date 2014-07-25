var buildColorGraph = function() {
    var stats,
        stats_data,
        stats_data3,
        false_states;
    $.ajax({url: '/users/data', async: false})
    .done(function(response){
        stats = response;
        stats_data = [];
        stats_data3 = [];
        false_states = [];
        stats_data.push(Math.round((stats.colors_true[1] || 0)/(20.0) *100));
        stats_data.push(Math.round((stats.colors_true[2] || 0)/(20.0) *100));
        stats_data.push(Math.round((stats.colors_true[3] || 0)/(20.0) *100));
        stats_data.push(Math.round((stats.colors_true[4] || 0)/(20.0) *100));
        stats_data_total = (eval(stats_data.join('+')));
        false_states.push(100 - stats_data_total);
    });

    $(function () {
            var colors = Highcharts.getOptions().colors,
                categories = ['hit','miss'],
                name = 'Color',
                data = [{
                        y: stats_data_total,
                        color: colors[0],
                        drilldown: {
                            name: 'Hit',
                            categories: ['Green','Purple','Red','Yellow'],
                            data: stats_data,
                            color: colors[0]
                        }
                    }, {
                        y: 100 - stats_data_total,
                        color: colors[4],
                        drilldown: {
                            name: 'miss',
                            categories: ['Incorrect'],
                            data: false_states,
                            color: colors[4]
                        }
                    }];

            // Build the data arrays
            var browserData = [];
            var versionsData = [];
            for (var i = 0; i < data.length; i++) {

                // add browser data
                browserData.push({
                    name: categories[i],
                    y: data[i].y,
                    color: data[i].color
                });

                // add version data
                for (var j = 0; j < data[i].drilldown.data.length; j++) {
                    var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
                    versionsData.push({
                        name: data[i].drilldown.categories[j],
                        y: data[i].drilldown.data[j],
                        color: Highcharts.Color(data[i].color).brighten(brightness).get()
                    });
                }
            }

            // Create the chart
            $('#ColorGraph').highcharts({
                 credits: {
                    enabled: false
                },
                chart: {
                    type: 'pie'
                },
                title: {
                    text: 'Color Graph'
                },
                yAxis: {
                    title: {
                        text: 'Total percent market share'
                    }
                },
                plotOptions: {
                    pie: {
                        shadow: false,
                        center: ['50%', '50%']
                    }
                },
                tooltip: {
                  valueSuffix: '%'
                },
                series: [{
                    name: 'Answers',
                    data: browserData,
                    size: '40%',
                    dataLabels: {
                        formatter: function() {
                            return this.y > 5 ? this.point.name : null;
                        },
                        color: 'white',
                        distance: -30
                    }
                }, {
                    name: 'Versions',
                    data: versionsData,
                    size: '60%',
                    innerSize: '40%',
                    dataLabels: {
                        formatter: function() {
                            // display only if larger than 1
                            return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ this.y +'%'  : null;
                        }
                    }
                }]
            });
        });

};