extends THBase

class_name THLogin

func _init(email, pw, obj, method_name).(obj, method_name):
	self.email = email
	self.pw = pw

func getEndpoint():
	return "/login"

func getRequestBody():
	return JSON.print({"email": seld.email, "pw": self.pw})

func getRequestType():
	return HTTPClient.METHOD_POST
