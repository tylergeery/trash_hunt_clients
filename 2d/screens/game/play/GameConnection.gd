extends Node


# Declare member variables here. Examples:
var _ws = null


func new():
	_ws = WebSocketClient.new()
	_ws.connect("connection_established", self, "_connection_established")
	_ws.connect("connection_closed", self, "_connection_closed")
	_ws.connect("connection_error", self, "_connection_error")
	_ws.connect("data_received", self, "_data_received")

	var url = "ws://localhost:8080"
	print("Connecting to " + url)
	_ws.connect_to_url(url)


func _connection_established(protocol):
	print("Connection established with protocol: ", protocol)


func _connection_closed():
	print("Connection closed")


func _connection_error():
	print("Connection error")


func _data_received():
	print("Connection error")


func send():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
