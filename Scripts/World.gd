extends Node2D

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 1909
var positionNode = [100,200]
var example_script = preload("res://Scripts/example.gd").new()

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "on_connection_succeeded")
	
func _on_connection_failed():
	print("Failed to connect")

func on_connection_succeeded():
	print("Succesfully connected")

func _on_Button_pressed():
	var label = get_tree().get_root().get_node("World/Label")
	example_script.saludo('Bastian')
	example_script.change_label(label)


func _on_TouchScreenButton_pressed():
	var label = get_tree().get_root().get_node("World/Label")
	example_script.change_label(label)
