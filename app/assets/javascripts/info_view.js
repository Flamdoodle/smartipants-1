function InfoView(){};

InfoView.prototype = {
    drawInstructions: function(){
        $('#instructions-pane').show();
        $('#example').empty();
        $('#reset-instructions').hide()
        $('#instructions-title').text("How to Play")
        $('#instructions-body p').show();
        $('#show-example').show()
    },
    drawExample: function(){
        console.log('test');
        var exampleTarget = "#example";
        $('#show-example').hide();
        $('#reset-instructions').show();
        $('#instructions-body p').hide();
        $('#instructions-title').text("Rollover tiles for info...");
        $( "<td id='ex-1' class='btn' style='display: none; height:10em; width: 10em; background-color: blue; margin-right: .5em'></td>" ).appendTo(exampleTarget)
        $( "<td id='ex-2' class='btn' style='display: none; height:10em; width: 10em; background-color: red; margin-right: .5em'></td>" ).appendTo(exampleTarget)
        $( "<td id='ex-3' class='btn' style='display: none; height:10em; width: 10em; background-color: blue;'></td>" ).appendTo(exampleTarget)
        $('#ex-1').popover({trigger: 'hover', title: 'Round 1', content: "This is the first square so you don't need to do anything", placement: 'left'});
        $('#ex-2').popover({trigger: 'hover', title: 'Round 2', content: "This is the second and you still don't need to do anything", placement: 'bottom'});
        $('#ex-3').popover({trigger: 'hover', title: 'Round 3', content: "This is a 2-back color match!", placement: 'bottom'});
        $('#ex-1').fadeIn();
        setTimeout(function() {
            $('#ex-2').fadeIn()
        }, 1000);
        setTimeout(function() {
            $('#ex-3').fadeIn()
        }, 2000);
    },
    hideInfoModals: function(){
        $('#instructions-pane').hide();
        $('#about-modal').hide();
    },
    drawAboutPage: function(){
        $('#about-modal').show();
    }

}