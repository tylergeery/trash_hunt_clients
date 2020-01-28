extends BaseScreen

class_name FormScreen

func is_valid_length(val, n):
	return len(val) >= n

func is_valid_email(email):
	return self.is_valid_length(email, 4)

func is_valid_password(password):
	return is_valid_length(password, 4)

func show_error(err):
	print("error: ", err)

func validate():
	return true

func submit():
	pass

func persistent_log_in_user():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		config.set_value('user', 'logged_in', 1)

	get_tree().change_scene("res://game/GameSettings.tcsn")

func validate_and_submit():
	if validate():
		submit()

func handle_success(response):
	self.log("success response: " + str(response))

func handle_error(err):
	self.log("error response: " + err)

func handle_response(response_code, response):
	if response_code != 201:
		return self.handle_error(response)

	return self.handle_success(response)
