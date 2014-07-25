function NavbarController(){
    this.sessionView = new SessionView();
    this.infoView = new InfoView();
    this.navbarListener = new NavbarListener(this);
}
NavbarController.prototype = {
    askForSessionInfo: function(selector){
        if (selector === 'signup'){
            this.sessionView.drawSignupForm();
        } else {
            this.sessionView.drawLoginForm();
        }
    },
    produceGameInfo: function(selector){
        if(selector === 'instructions'){
            this.infoView.drawInstructions();
        } else if(selector === 'demo'){
            this.infoView.drawExample();
        } else {
            this.infoView.drawAboutPage();
        }
    },
    closeInfo: function(){
        this.infoView.hideInfoModals();        
    }
}