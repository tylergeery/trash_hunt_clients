extends BaseNode


# Declare member variables here. Examples:
var game_start = false
var maze = []
var time_since_move = 0
var GameConnection = preload("res://screens/game/play/GameConnection.tscn")

var _connection = null
var GAME_TILE_NO_WALLS = preload("res://screens/game/play/maze/MazeSpotNoWalls.tscn")
var GAME_TILE_1_WALL = preload("res://screens/game/play/maze/MazeSpot1Wall.tscn")
var GAME_TILE_2_WALLS = preload("res://screens/game/play/maze/MazeSpot2Walls.tscn")
var GAME_TILE_2_WALLS_SPLIT = preload("res://screens/game/play/maze/MazeSpot2WallsSplit.tscn")
var GAME_TILE_3_WALLS = preload("res://screens/game/play/maze/MazeSpot3Walls.tscn")
var GAME_TILE_ALL_WALLS = preload("res://screens/game/play/maze/MazeSpot4Walls.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.initialize_game_connection()
	self.set_process(true)


func get_identifier():
	return "GamePlay"


func initialize_game_connection():
	var settings = GameStart.get_settings()
	var game_request = {
		"user_token": self.get_user_value("token"),
		"opponent": settings["opponent"],
		"difficulty": settings["difficulty"]
	}

	print("Game Request: ", game_request)
	self.log("Starting game with settings:" + str(game_request))
	_connection = GameConnection.instance()
	_connection.new(game_request)
	self.add_child(_connection)

	_connection.connect("game_connect", self, "on_game_connect")
	_connection.connect("game_pending", self, "on_game_pending")
	_connection.connect("game_start", self, "on_game_start")
	_connection.connect("game_state_update", self, "on_game_state_update")
	_connection.connect("game_complete", self, "on_game_complete")
	_connection.connect("game_error", self, "on_game_error")


func on_game_connect():
	print("Game connected")

func on_game_pending():
	print("Game pending")

func on_game_start():
	print("Game starting")

func on_game_state_update(state):
	print("Game state update", state)

func on_game_complete():
	print("Game complete")

func on_game_error(error):
	print("Game error", error)


func countdown():
	# TODO: handle countdown through _process
	pass

func create_maze():
	pass


func _unhandled_input(event):
	# collect move
	if event is InputEventAction:
		print("event:", event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.log("Processing from game connection")
	if not game_start:
		self.countdown()
		return

	time_since_move += delta
	if time_since_move >= 1000:
		# send move
		_connection.send({})
		time_since_move = 0

