extends Control

# Declare member variables here. Examples:
var email = ""
var password = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("LoginContainer/LoginButtonHolder/Button").connect("button_up", self, "validate_and_submit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey:
		email = get_node("LoginContainer/EmailInput/LineEdit").get_text()
		password = get_node("LoginContainer/PasswordInput/LineEdit").get_text()

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
		return false

	return true

func submit():
	print("submitting login: ", email, " ", password)
	var login_request = get_node("LoginContainer/LoginRequest")
	login_request.register(email, password, self, "handle_login_response")
	login_request.send()

func handle_login_response(response):
	print("response: ", response)

func validate_and_submit():
	if validate():
		submit()