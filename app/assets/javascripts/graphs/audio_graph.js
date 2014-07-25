var buildAudioGraph = function(){
    var stats,
        stats_data2,
        stats_data4,
        stats_data2_total,
        false_states_array_audio;
    $.ajax({url: '/users/data', async: false})
    .done(function(response){
        stats = response;
        stats_data2 = [];
        stats_data4 = [];
        false_states_array_audio = [];
        stats_data2.push(Math.round((stats.audios_true[1] || 0)/(20.0) *100));
        stats_data2.push(Math.round((stats.audios_true[2] || 0)/(20.0) *100));
        stats_data2.push(Math.round((stats.audios_true[3] || 0)/(20.0) *100));
        stats_data2.push(Math.round((stats.audios_true[4] || 0)/(20.0) *100));
        stats_data2_total = (eval(stats_data2.join('+')));
        false_states_array_audio.push(100 - stats_data2_total);
    });
    $(function(){
        var colors = Highcharts.getOptions().colors,
            categories = ['hit','miss'],
            name = 'Audio',
            data = [{
                    y: stats_data2_total,
                    color: colors[0],
                    drilldown: {
                        name: 'Hit',
                        categories: ['K','R','L','F'],
                        data: stats_data2,
                        color: colors[0]
                    }
                },
                {
                    y: 100 - stats_data2_total,
                    color: colors[4],
                    drilldown: {
                        name: 'miss',
                        categories: ['Incorrect'],
                        data: false_states_array_audio,
                        color: colors[4]
                    }
            }];

        // Build the data arrays
        var browserData = [];
        var versionsData = [];
        for (var i = 0; i < data.length; i++){

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
        $('#AudioGraph').highcharts({
            credits: {
                enabled: false
            },
            chart: {
                type: 'pie'
            },
            title: {
                text: 'Audio Graph'
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