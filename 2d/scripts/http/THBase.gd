extends HTTPRequest

class_name THBase


func _init(obj, method_name):
	self.obj = obj
	self.method_name = method_name
	self.connect("request_completed", self, "done")

func getEndpoint():
	return ""

func getURL():
	return self.getBaseURL() + self.getEndpoint()

func getBaseURL():
	return "localhost:8000"

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
	return $HTTPRequest.request(
		self.getURL(),
		self.getHeaders(),
		self.useSSL(),
		self.getRequestType(),
		self.getRequestBody()
	)

func done(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("HTTP Result: ", json.result)
	self.obj.call(self.method_name, [response_code, json.result])
	