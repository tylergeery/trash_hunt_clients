extends BaseScreen

func get_identifier():
	return "SplashPage"

func show_login_screen():
	get_tree().change_scene("res://screens/login/LoginScreen.tscn")

func show_registration_screen():
	get_tree().change_scene("res://screens/registration/RegistrationScreen.tscn")

func show_game_settings_screen():
	get_tree().change_scene("res://screens/game/GameSettings.tscn")

func _ready():
	self.log("loading")
	if self.get_user_value('id'):
		return
	if self.get_user_value('logged_in'):
		self.log("user seen before, going to login")
		return show_login_screen()

	self.log("user never seen, going to registration")
	return show_registration_screen()
