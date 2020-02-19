extends Control


const START_GAME_BUTTON = "ColorRect/MarginContainer/VBoxContainer/StartGame/StartGameButton"
const OPTION_BUTTON = "ColorRect/MarginContainer/VBoxContainer/Opponent/OptionButton"
const COMPUTER_OPTIONS = "ColorRect/MarginContainer/VBoxContainer/ComputerOptions"
const FRIEND_OPTIONS = "ColorRect/MarginContainer/VBoxContainer/FriendOptions"
const RANDOM_OPTIONS = "ColorRect/MarginContainer/VBoxContainer/RandomOptions"

# Declare member variables here. Examples:
# modes - 0 = comp, 1 = random, 2 = friend
var mode = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(OPTION_BUTTON).connect("item_selected", self, "game_mode_selected")
	get_node(START_GAME_BUTTON).connect("pressed", self, "start_game_pressed")

	#TODO: Only allow one difficulty level to be chosen

func game_mode_selected(id):
	mode = id
	show_mode_options()


func show_mode_options():
	if mode == 0:
		get_node(COMPUTER_OPTIONS).visible = true
		get_node(FRIEND_OPTIONS).visible = false
		get_node(RANDOM_OPTIONS).visible = false
	if mode == 1:
		get_node(COMPUTER_OPTIONS).visible = false
		get_node(FRIEND_OPTIONS).visible = false
		get_node(RANDOM_OPTIONS).visible = true
	if mode == 2:
		get_node(COMPUTER_OPTIONS).visible = false
		get_node(FRIEND_OPTIONS).visible = true
		get_node(RANDOM_OPTIONS).visible = false


func start_game_pressed():
	GameStart.start({
		"opponent": -1,
		"difficulty": 1
	})


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
