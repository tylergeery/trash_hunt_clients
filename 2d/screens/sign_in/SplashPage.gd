extends BaseScreen

func getIdentifier():
	return "SplashPage"

func show_login_screen():
	get_tree().change_scene("res://screens/login/LoginScreen.tscn")

func show_registration_screen():
	get_tree().change_scene("res://screens/registration/RegistrationScreen.tscn")

func _ready():
	self.log("loading")
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		var seen_user = config.get_value('user', 'logged_in')
		if seen_user:
			self.log("user seen before, going to login")
			return show_login_screen()

	self.log("user never seen, going to registration")
	return show_registration_screen()
