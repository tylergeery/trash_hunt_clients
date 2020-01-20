extends Control

# Declare member variables here. Examples:
var email = ""
var password = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("VBoxContainer/VBoxContainer/Button").connect("button_up", self, "validate_and_submit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey:
		email = get_node("VBoxContainer/EmailInput/LineEdit").get_text()
		password = get_node("VBoxContainer/PasswordInput/LineEdit").get_text()

func is_valid_email():
	return len(email) > 3

func is_valid_password():
	return len(password) > 3

func validate():
	if not is_valid_email():
		print("TODO: invalid email")
		return false

	if not is_valid_password():
		print("TODO: invalid pass")
		return true

func submit():
	pass

func handle_login_response(response):
	print("response: ", response)

func validate_and_submit():
	if validate():
		submit()