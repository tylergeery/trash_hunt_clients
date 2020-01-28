extends FormScreen

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

func getIdentifier():
	return "LoginScreen"

func validate():
	if not is_valid_email(email):
		self.log("TODO: invalid email")
		return false

	if not is_valid_password(password):
		self.log("TODO: invalid pass")
		return false

	return true

func submit():
	self.log("submitting login: " + email + " " + password)
	var login_request = get_node("LoginContainer/LoginRequest")
	login_request.register(email, password, self, "handle_response")
	login_request.send()

func handle_error(err):
	self.log("TODO: handle login err: " + err)

func handle_success(response):
	self.log("login response " + str(response))
	self.persistent_log_in_user()
