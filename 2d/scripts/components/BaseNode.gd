extends Node2D

class_name BaseNode

var config = null
var err = null

func get_identifier():
	return "BaseNode"

func log(msg):
	return self.get_identifier() + ": " + msg

func get_user_config() -> ConfigFile:
	if err == OK:
		return config

	config = ConfigFile.new()
	err = config.load("user://user.cfg")

	if err != OK:
		self.log("Error: could not open user config")

	return config

func get_user_value(key: String):
	return self.get_user_config().get_value('user', key)

func set_user_value(key: String, value):
	self.get_user_config().set_value('user', key, value)
