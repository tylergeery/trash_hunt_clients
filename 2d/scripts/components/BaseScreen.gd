extends Control

class_name BaseScreen

func getIdentifier():
	return "BaseScreen"

func log(msg):
	return self.getIdentifier() + ": " + msg
