function SessionView(){};

SessionView.prototype = {
    drawSignupForm: function(){
        $('#signup-modal').show();
    },
    drawLoginForm: function(){
        $('#login-modal').show();
    }
}