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
	self.create_socket_connection()


func get_identifier():
	return "BaseNode"

func create_socket_connection():
	var settings = GameStart.get_settings()
	var game_request = {
		"user_token": self.get_user_value("token"),
		"opponent": settings["opponent"],
		"difficulty": settings["difficulty"]
	}

	self.log("Starting game with settings:" + str(game_request))
	_connection = GameConnection.instance()
	_connection.new()


func countdown():
	pass


func create_maze():
	pass


func _unhandled_input(event):
	if event is InputEventAction:
		print("event:", event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_move += delta
	if time_since_move >= 1000:
		# send move
		pass

