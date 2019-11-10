class Screen {
    /**
     * @param {DomElement} container
     */
    constructor(container) {
        this.container = container;
        this.subscribers = [];
        this._html_cache = null;
    }

    render() {
        this.container.innerHTML = this._get_html();
    }

    on(fn) {
        this.subscribers.push(fn)
    }

    emit(action, data) {
        for (let i = 0; i < this.subscribers.length; i++) {
            this.subscribers[i](action, data);
        }
    }

    clear() {
        if (this.container) {
            this._html_cache = this.container.innerHTML;
            this.container.innerHTML = '';
        }
    }

    setup() {
        this.preSetup && this.preSetup();
        this.render();
        this.setListeners();
        this.postSetup && this.postSetup();
    }
}


class FormScreen extends Screen {
    showError(el, value) {
        // TODO
        debugger;
        return true;
    }

    clearErrors() {
        // TODO
        let errors = document.querySelectorAll('.error');
    }
}
