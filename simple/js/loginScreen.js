class LoginScreen extends FormScreen {
    /**
     * @return {string}
     */
    _get_html() {
        return `
            <div>
                <h3>Login</h3>
                <div>
                    <div>
                        <label>
                        Email:
                        <input type="text" name="email" id="login-email" />
                        </label>
                    </div>
                    <div>
                        <label>
                        Password:
                        <input type="text" name="pw" id="login-pw" />
                        </label>
                    </div>
                    <div>
                        <button type="button" id="login-submit">Submit</button>
                    </div>
                </div>
            </div>
        `;
    }

    setListeners() {
        let submitButton = this.container.querySelector('#login-submit');

        submitButton.onclick = () => {
            console.log('Logging in user');
            let err = null;
            let emailField = this.container.querySelector('#login-email');
            let passwordField = this.container.querySelector('#login-pw');

            if (!emailField.value) {
                err = this.showError(emailField, 'No email provided')
            }
            if (!passwordField.value) {
                err = this.showError(passwordField, 'No password provided')
            }

            if (err) {
                return;
            }

            this.clearErrors();
            this.loginUser(emailField.value, passwordField.value)
                .then((user) => {
                    console.log('Log-in success');
                    this.emit('login', user);
                }, (error) => {
                    console.log('Log-in error');
                    debugger;
                    // TODO: handle error
                });
        };
    }

    /**
     * Get token for user to start game with
     *
     * @param {string} email
     * @param {string} pw
     * @return {Promise}
     */
    loginUser(email, pw) {
        return new Promise((resolve, reject) => {
            fetch(
                'http://localhost:3000/login/',
                {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    mode: 'cors',
                    cache: 'no-cache',
                    redirect: 'follow',
                    referrer: 'no-referrer',
                    body: JSON.stringify({
                        email,
                        pw,
                    }),
                }
            ).then((result) => {
                result.json().then((json) => {
                    json['player']['user_token'] = json['token'];
                    console.log('User Token result:', json['player']);
                    resolve(json['player']);
                })
            }, (response) => {
                reject(response);
            })
        })
    }
}
