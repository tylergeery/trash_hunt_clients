extends Node

const GAMEPLAY_SCENE = "res://screens/game/play/GamePlay.tscn"

# Declare member variables here. Examples:
var _settings = {}


func start(settings):
	_settings = settings
	get_tree().change_scene(GAMEPLAY_SCENE)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
