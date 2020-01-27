extends THBase

class_name THRegistration

var email = ""
var pw = ""
var username = ""

func register(_email, _pw, _username, obj, method_name):
	._register(obj, method_name)
	email = _email
	pw = _pw
	username = _username

func getEndpoint():
	return "/register/"

func getRequestBody():
	print("JSON body: ", JSON.print({"email": email, "pw": pw}))
	return JSON.print({"email": email, "pw": pw, "username": username})

func getRequestType():
	return HTTPClient.METHOD_POST
