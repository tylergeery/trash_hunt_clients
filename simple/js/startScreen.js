class StartScreen extends Screen {
    /**
     * @param {object} user
     * @return {string}
     */
    _get_html(user) {
        return `
            <div>
                <p>TODO: Options to select game preferences</p>
                <br />
                <button type="button" id="start-game">Start Game</button>
            </div>
        `
    }

    /**
     * @param {function) onComplete
     */
    setListeners() {
        let gameButton = this.container.querySelector('#start-game');

        gameButton.onclick = () => {
            this.emit('start', this.getGameOptions());
        }
    }

    /**
     * @returns {Object}
     */
    getGameOptions(user) {
        return {
            'difficulty': 'easy',
            'opponent': -1
        }
    }
}
