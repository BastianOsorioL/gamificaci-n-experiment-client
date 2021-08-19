extends Control


onready var chat_display = $VBoxContainer/TextEdit
onready var chat_input = $VBoxContainer/LineEdit

func _ready():
	chat_input.connect("text_entered", self, "send_message")

func send_message(msg):
	chat_input.text = ""
	var id = get_tree().get_network_unique_id()
	var private_id = GlobalVar.sendMsgPlayerId
	rpc_id(private_id, "receive_message", id, msg)
	
remotesync func receive_message(id, msg):
	chat_display.text += str(id) + ": " + msg + "\n"	
