extends Node2D


# Declare member variables here. Examples:
var _conn = null


func new():
	_conn = StreamPeerTCP.new()

	print("Connecting to localhost:3001")
	var err = _conn.connect_to_host("localhost", 3001)
	if err:
		print("Error connecting to localhost:3001, ", err)


func _connection_established(protocol):
	print("Connection established with protocol: ", protocol)


func _connection_closed():
	print("Connection closed")


func _connection_error():
	print("Connection error")


func _data_received():
	print("Connection error")


func send(data):
	if not data is String:
		data = JSON.print(data)

	_conn.put_string(data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
