class RegistrationScreen extends FormScreen {
    /**
     * @return {string}
     */
    _get_html() {
        return `
            <div>
                <h3>Register</h3>
                <div>
                    <div>
                        <label>
                        Name:
                        <input type="text" name="name" id="register-name" />
                        </label>
                    </div>
                    <div>
                        <label>
                        Email:
                        <input type="text" name="email" id="register-email" />
                        </label>
                    </div>
                    <div>
                        <label>
                        Password:
                        <input type="text" name="pw" id="register-pw" />
                        </label>
                    </div>
                    <div>
                        <button type="button" id="register-submit">Register</button>
                    </div>
                </div>
            </div>
        `
    }

    setListeners() {
        let submitButton = this.container.querySelector('#register-submit');

        submitButton.onclick = () => {
            console.log('Registering user');
            let err = null;
            let emailField = this.container.querySelector('#register-email');
            let nameField = this.container.querySelector('#register-name');
            let passwordField = this.container.querySelector('#register-pw');

            if (!emailField.value) {
                err = this.showError(emailField, 'No email provided');
            }

            if (!nameField.value) {
                err = this.showError(nameField, 'No name provided');
            }

            if (!passwordField.value) {
                err = this.showError(passwordField, 'No password provided');
            }

            if (err) {
                return;
            }

            this.createUser(emailField.value, nameField.value, passwordField.value)
                .then((user) => {
                    console.log('Register success');
                    this.emit('register', user);
                }, (error) => {
                    console.log('register error');
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
    createUser(email, username, pw) {
        return new Promise((resolve, reject) => {
            fetch(
                'http://localhost:3000/v1/player/',
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
                        username,
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
