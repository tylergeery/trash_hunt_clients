extends Control

# Declare member variables here. Examples:
var email = ""
var password = ""
var username = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("RegistrationContainer/RegistrationButtonHolder/Button").connect("button_up", self, "validate_and_submit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey:
		email = get_node("RegistrationContainer/EmailInput/LineEdit").get_text()
		password = get_node("RegistrationContainer/PasswordInput/LineEdit").get_text()
		username = get_node("RegistrationContainer/UsernameInput/LineEdit").get_text()

func is_valid_length(val, n):
	return len(val) >= n

func is_valid_email():
	return is_valid_length(email, 4)

func is_valid_password():
	return is_valid_length(password, 4)

func validate():
	if not is_valid_email():
		print("TODO: invalid email")
		return false

	if not is_valid_password():
		print("TODO: invalid pass")
		return false

	if not is_valid_length(username, 4):
		print("TODO: invalid username")
		return false

	return true

func submit():
	print("submitting registration: ", email, " ", password)
	var reg_request = get_node("RegistrationContainer/RegistrationRequest")
	reg_request.register(email, password, username, self, "handle_response")
	reg_request.send()

func handle_response(response):
	print("response: ", response)

func validate_and_submit():
	if validate():
		submit()