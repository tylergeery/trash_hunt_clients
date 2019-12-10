class SetUp {
    constructor(setupScreen, gameScreen) {
        this.setupScreen = setupScreen
        this.gameScreen = gameScreen
        this.setup()
    }

    setup() {
        // TODO: clear game screen
        this.gameScreen.clear();
        this.setupScreen.setup();
        this.setupScreen.on(this.startGame.bind(this))
    }

    startGame(action, data) {
        console.log('STARTING GAME');
        this.setupScreen.clear();
        this.gameScreen.setup(data);
        this.gameScreen.on(this.endGame.bind(this));
    }

    endGame(action, data) {
        console.log('ENDING GAME');
        this.connection && this.connection.close();
        this.connection = null;
        this.gameScreen.clear();
        this.setup();
    }
}


let setupScreen = new SetupScreen(document.getElementById('setup-screen'));
let gameScreen = new GameScreen(document.getElementById('game-canvas'));
let setup = new SetUp(setupScreen, gameScreen);
