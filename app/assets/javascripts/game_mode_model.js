function GameModeModel(){
    this.position = true;
    this.sound = false;
    this.color = false;
}
GameModeModel.prototype = {
    updateGameMode: function(gameMode){
        if(gameMode === 'single'){
            this.position = true;
            this.sound = false;
            this.color = false;
        } else if(gameMode === 'dual'){
            this.position = true;
            this.sound = true;
            this.color = false;
        } else {
            this.position = true;
            this.sound = true;
            this.color = true;
        }
    },
    assessGameMode: function(){
        if(this.sound){
            if(this.color){
                return 'triple'
            } else {
                return 'dual'
            };
        } else {
            return 'single'
        };
    }
}