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

func persistent_logged_in_user(user):
	self.set_user_value('logged_in', 1)
	self.set_user_value('id', user['id'])
	self.set_user_value('username', user['username'])

	get_tree().change_scene("res://screens/game/GameSettings.tscn")

func validate_and_submit():
	if validate():
		submit()

func handle_success(response):
	self.log("success response: " + str(response))

func handle_error(err):
	self.log("error response: " + err)

func handle_response(response_code, response):
	if response_code >= 400:
		return self.handle_error(response)

	return self.handle_success(response)
