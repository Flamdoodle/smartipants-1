function NavbarListener(delegate){
    this.delegate = delegate;
    this._setupListeners();
};

NavbarListener.prototype = {
    _setupListeners: function(){
        $('#open-instructions').click(function(e){
            e.preventDefault();
            this.delegate.produceGameInfo('instructions');
        }.bind(this))
        $('#signup').click(function(e){
            e.preventDefault();
            this.delegate.askForSessionInfo('signup');
        }.bind(this))
        $('#login').click(function(e){
            e.preventDefault();
            this.delegate.askForSessionInfo('login');
        }.bind(this))
        $('#about').click(function(e){
            e.preventDefault();
            this.delegate.produceGameInfo('about');
        }.bind(this))
        $('#close-instructions').click(function(e){
            e.preventDefault();
            this.delegate.closeInfo();
        }.bind(this))
        $('#show-example').click(function(e){
            e.preventDefault();
            this.delegate.produceGameInfo('demo');
        }.bind(this))
        $('#reset-instructions').click(function(e){
            e.preventDefault();
            this.delegate.produceGameInfo('instructions');
        }.bind(this))
    }
}