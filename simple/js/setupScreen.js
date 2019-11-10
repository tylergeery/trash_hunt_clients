class SetupScreen extends Screen {
    _get_html() {
        if (!this.user) {
            return `
                <div>
                    <button type="button" class="toggle-button" data-value="login">Login</button>
                    <button type="button" class="toggle-button" data-value="register">Register</button>
                </div>

                <div id="start-content-frame"></div>
            `;
        }

        return `
            <div>
                <button type="button" id="logout">Logout</button>
            </div>

            <div id="start-content-frame"></div>
        `;
    }

    /**
     * @return {Object}
     */
    getUserInfoFromStorage() {
        var user = null;
        try {
            user = window.localStorage.getItem('user')
        } catch(e) {
            console.error('localStorage.getItem error:', e);
            return this.user;
        }

        if (!user) {
            return null;
        }

        this.user = JSON.parse(user);

        return user;
    }

    /**
     * @param {Object} user
     * @return {bool
     */
    setUserToStorage(user) {
        this.user = user;
        if (!user) {
            try {
                return window.localStorage.removeItem('user');
            } catch (e) {
                console.error('localStorage.removeItem error:', e);
                return null;
            }

        }

        try {
            return window.localStorage.setItem('user', JSON.stringify(user));
        } catch (e) {
            console.error('localStorage.setItem error:', e);
            return null;
        }
    }

    waitForActions() {
        this.loginScreen.on(this.handleAction.bind(this));
        this.registrationScreen.on(this.handleAction.bind(this));
        this.startScreen.on(this.handleAction.bind(this));
    }

    /**
     * @param {string} action
     * @param {Object} data
     */
    handleAction(action, data) {
        switch(action) {
            case 'login':
            case 'register':
                this.setUserToStorage(data);
                this.setup();
                break;
            case 'start-screen':
                this.loginScreen.clear();
                this.registrationScreen.clear();
                this.startScreen.setup();
                break;
            case 'toggle-register':
                this.loginScreen.clear();
                this.startScreen.clear();
                this.registrationScreen.setup();
                break;
            case 'start':
                data.user_token = this.user.user_token;
                this.emit('start', {user: this.user, options: data});
                break;
            default:
                this.registrationScreen.clear();
                this.startScreen.clear();
                this.loginScreen.setup();
                break;
        }
    }

    setListeners() {
        let container = document.querySelector('#start-content-frame');

        this.loginScreen = new LoginScreen(container);
        this.registrationScreen = new RegistrationScreen(container);
        this.startScreen = new StartScreen(container);

        let toggleButtons = document.querySelectorAll('.toggle-button');
        for (let i = 0; i < toggleButtons.length; i++) {
            toggleButtons[i].onclick = (el) => {
                this.handleAction('toggle-' + el.target.attributes['data-value'].nodeValue);
            }
        }

        let logoutButton = document.querySelector('#logout');
        if (logoutButton) {
            logoutButton.onclick = () => {
                this.setUserToStorage(null);
                this.setup();
            }
        }
    }

    preSetup() {
        this.getUserInfoFromStorage();
    }

    postSetup() {
        this.waitForActions();

        if (!this.user) {
            return this.handleAction('setup');
        }

        this.handleAction('start-screen', this.user);
    }
}
