extends Node2D


# Declare member variables here. Examples:
var game_start = false
var maze = []
var time_since_move = 0
var GameConnection = preload("res://screens/game/play/GameConnection.gd")

var _connection = null


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create socket connection
	_connection = GameConnection.instance()
	_connection.new()

	# Figure out what type of game the player wants

	# countdown

	# draw map
	pass # Replace with function body.


func create_socket_connection():
	pass


func countdown():
	pass


func create_maze():
	pass


func _unhandled_input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_move += delta
	if time_since_move >= 1000:
		# send move
		pass
