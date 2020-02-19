extends Node2D


signal game_error
signal game_connected
signal game_pending
signal game_start
signal game_state_update
signal game_complete

# Declare member variables here. Examples:
var _conn = null
var _game_settings = null
var _game_state = null
var _game_interval = 0

enum GameState {
	UNSTARTED
	INIT
	PENDING
	ACTIVE
	COMPLETE
}


func new(game_settings):
	_conn = StreamPeerTCP.new()
	_game_settings = game_settings
	_game_state = GameState.UNSTARTED

	print("Connecting to localhost:3001")
	var err = _conn.connect_to_host("localhost", 3001)
	if err:
		print("Error connecting to localhost:3001, ", err)
		self.emit_signal("game_error", "Could not connect to game server")

func _check_connection():
	breakpoint
	if _conn.get_status() == _conn.STATUS_CONNECTED:
		_game_state = GameState.INIT
		print("Sending game settings", _game_settings)
		self.send(_game_settings)
		print("Sending game connected signal")
		self.emit_signal("game_connected")


func _process_input():
	var input = _conn.get_string()
	if not input:
		return

	# TODO: do better, state machine
	# Parse messages depending on state, send appropriate signals
	var msg = JSON.parse(input)
	if _game_state == GameState.INIT:
		if msg.data != "Status: Pending":
			self.emit_signal("game_error", "Unknown game error: " + str(msg))
			return
		self.emit_signal("game_pending")
	elif _game_state == GameState.PENDING:
		# Validate msg
		self.emit_signal("game_start")
	elif _game_state == GameState.ACTIVE:
		# Validate msg, check for winner
		if false:
			self.emit_signal("game_complete")

		self.emit_signal("game_state_update")


func send(data):
	if not data is String:
		data = JSON.print(data)

	_conn.put_string(data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _game_state == GameState.COMPLETE:
		return

	if _game_state == GameState.UNSTARTED:
		self._check_connection()

	_game_interval += delta
	if _game_interval > 1:
		self._process_input()
		_game_interval = 0
