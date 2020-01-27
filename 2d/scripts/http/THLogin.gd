extends THBase

class_name THLogin

var email = ""
var pw = ""

func register(_email, _pw, obj, method_name):
	._register(obj, method_name)
	email = _email
	pw = _pw

func getEndpoint():
	return "/login/"

func getRequestBody():
	print("JSON body: ", JSON.print({"email": email, "pw": pw}))
	return JSON.print({"email": email, "pw": pw})

func getRequestType():
	return HTTPClient.METHOD_POST
