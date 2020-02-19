extends FormScreen

const LOGIN_LINK = "RegistrationContainer/HBoxContainer/LoginLink"
const REGISTER_SUBMIT_BUTTON = "RegistrationContainer/RegistrationButtonHolder/Button"

# Declare member variables here. Examples:
var email = ""
var password = ""
var username = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(REGISTER_SUBMIT_BUTTON).connect("button_up", self, "validate_and_submit")
	get_node(LOGIN_LINK).connect("button_up", self, "to_login_page")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey:
		email = get_node("RegistrationContainer/EmailInput/LineEdit").get_text()
		password = get_node("RegistrationContainer/PasswordInput/LineEdit").get_text()
		username = get_node("RegistrationContainer/UsernameInput/LineEdit").get_text()

func to_login_page():
	get_tree().change_scene("res://screens/login/LoginScreen.tscn")

func get_identifier():
	return "RegistrationScreen"

func validate():
	if not is_valid_email(email):
		self.log("TODO: invalid email")
		return false

	if not is_valid_password(password):
		self.log("TODO: invalid pass")
		return false

	if not is_valid_length(username, 4):
		self.log("TODO: invalid username")
		return false

	return true

func submit():
	self.log("submitting registration: " + email + " " + password)
	var reg_request = get_node("RegistrationContainer/RegistrationRequest")
	reg_request.register(email, password, username, self, "handle_response")
	reg_request.send()

func handle_error(err):
	self.log("TODO: handle registration err: " + str(err))

func handle_success(response):
	self.set_user_value('token', response['token'])
	self.persistent_logged_in_user(response['player'])
