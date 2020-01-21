extends HTTPRequest

class_name THBase

var obj = null
var method_name = null

func _register(new_obj, new_method_name):
	print("registering: ", obj, "->", method_name)
	obj = new_obj
	method_name = new_method_name
	self.connect("request_completed", self, "done")

func getEndpoint():
	return ""

func getURL():
	return self.getBaseURL() + self.getEndpoint()

func getBaseURL():
	return "http://127.0.0.1:3000"

func getHeaders():
	return [
		"Content-Type: application/json",
	]

func getRequestBody():
	return null

func useSSL():
	return false

func getRequestType():
	return HTTPClient.METHOD_GET

func send():
	print("HTTP Request sending: ", self.getRequestType() , " : ", self.getURL(), " : ", self.getRequestBody())
	return self.request(
		self.getURL(),
		self.getHeaders(),
		self.useSSL(),
		self.getRequestType(),
		self.getRequestBody()
	)

func done(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("HTTP Result: ", body.get_string_from_utf8())
	obj.call(method_name, [response_code, json.result])

