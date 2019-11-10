class GameScreen extends Screen {
    render() {
        var ctx = this.container.getContext('2d');
        ctx.beginPath();

        // abckground
        ctx.fillStyle = '#964B00';
        ctx.fillRect(0, 0, this.container.width, this.container.height);
        ctx.fill();

        if (!this.state) {
            return;
        }

        var maze = this.state.maze,
            players = this.state.players;

        this._drawMaze(ctx, maze);
        for (var playerID in players) {
            if (!players.hasOwnProperty(playerID)) {
                continue;
            }

            this._drawPlayer(
                ctx,
                players[playerID].pos,
                playerID == this.user.id ? '#FF0' : '#0FF'
            );
        }

        this._drawTrash(ctx, maze.trashPos);
        this.setListeners();
    }

    _drawMaze(ctx, maze) {
        var width = this.container.width,
            height = this.container.height,
            ws = width / 10,
            hs = height / 10;

        // TODO: Tough one
        // loop through 3d array maze
        // draw line for each wall (1) that is found
        ctx.fillStyle = '#0F0';
        for (var y = 0; y < maze.walls.length; y++) {
            for (var x = 0; x < maze.walls[y].length; x++) {
                for (var pos = 0; pos < maze.walls[y][x].length; pos++) {
                    var wx = ws * x,
                        wy = hs * y;

                    if (!maze.walls[y][x][pos]) {
                        continue;
                    }

                    switch(pos) {
                        case 0:
                            ctx.beginPath();
                            ctx.moveTo(wx, wy);
                            ctx.lineTo(wx + ws, wy);
                            ctx.stroke();
                            break;
                        case 1:
                            ctx.beginPath();
                            ctx.moveTo(wx + ws, wy);
                            ctx.lineTo(wx + ws, wy + hs);
                            ctx.stroke();
                            break;
                        case 2:
                            ctx.beginPath();
                            ctx.moveTo(wx + ws, wy + hs);
                            ctx.lineTo(wx, wy + hs);
                            ctx.stroke();
                            break;
                        case 3:
                            ctx.beginPath();
                            ctx.moveTo(wx, wy + hs);
                            ctx.lineTo(wx, wy);
                            ctx.stroke();
                            break;
                    }
                }
            }
        }
    }

    _drawPlayer(ctx, pos, color) {
        var width = this.container.width,
            height = this.container.height,
            ws = width / 10,
            hs = height / 10;

        ctx.fillStyle = color;
        ctx.fillRect(
            ws * pos.x + 1,
            hs * pos.y + 1,
            10, 10
        );
        ctx.fill();
    }

    _drawTrash(ctx, pos) {
        var width = this.container.width,
            height = this.container.height,
            ws = width / 10,
            hs = height / 10;

        ctx.fillStyle = '#555';
        ctx.fillRect(
            ws * pos.x + 1,
            hs * pos.y + 1,
            10, 10
        );
        ctx.fill();
    }

    setListeners() {
        document.addEventListener('keyup', (e) => {
            switch (e.code) {
                case 'ArrowLeft':
                case 'KeyA':
                    this.connection.send('l');
                    break;
                case 'ArrowUp':
                case 'KeyW':
                    this.connection.send('u');
                    break;
                case 'ArrowRight':
                case 'KeyD':
                    this.connection.send('r');
                    break;
                case 'ArrowDown':
                case 'KeyS':
                    this.connection.send('d');
                    break;
            }
        });
    }

    handleMessage(message) {
        let msg = JSON.parse(message);

        switch (msg.event) {
            case 0: // Game Pending
                console.log('TODO: Start game, maybe a countdown');
            break;
            case 1: // Error
                console.log('TODO: Handle error');
            break;
            case 2: // Init game
                this.state = JSON.parse(msg.data);
                this.render();
            break;
            case 3: // Updated game state
                this.state.players = JSON.parse(msg.data);
                this.render();
            break;
            default:
                console.log('Unknown message:', msg);
        }
    }

    /**
     * @return {WebSocket}
     */
    setupConnection() {
        let ws = new WebSocket('ws://localhost:3002');

        ws.onmessage = (event) => {
            this.handleMessage(event.data);
        }

        ws.onclose = (event) => {
            console.log('WS closed: ', event);
            // TODO: should we try to reconnect
        }

        ws.onerror = (event) => {
            console.log('WS error: ', event);
            // TODO: should we try to reconnect
        }

        return ws;
    }

    /**
     * @param {Object} data
     */
    setup(data) {
        this.container.width  = 500;
        this.container.height = 500;

        this.user = data.user;
        this.connection = this.setupConnection();
        this.connection.onopen = () => {
            this.connection.send(JSON.stringify(data.options));
        }
    }

    clear() {
        // NoOp
    }
}
