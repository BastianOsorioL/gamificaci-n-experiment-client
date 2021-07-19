extends Node

var groups = []
var ownPlayerId
var players_in_map = []
onready var label = get_tree().get_root().get_node("World/Label")
onready var playerNode = get_tree().get_root().get_node("World/Player")
onready var playersOnlineNode = get_tree().get_root().get_node("World/PlayersOnline")
onready var dPad = get_tree().get_root().get_node("World/DPad/Control")

var example_script = load("res://Scripts/example.gd").new()

func send_hello():
	var msg = "Hola server desde el cliente"
	rpc_id(1, "receive_hello", msg)
	
func send_move():
	if players_in_map.size() > 0:
		rpc_unreliable_id(1, "receiverPositionPlayer", ownPlayerId, playerNode.get_position())
	
func set_players_position(player):
	var otherPlayerNode = get_tree().get_root().get_node("World/PlayersOnline/player" + str(player["playerId"]))
	var position = otherPlayerNode.get_position()
	set_players_state(position, player, otherPlayerNode)
	otherPlayerNode.set_position(player["position"])
	
func set_players_state(position, otherPlayer, otherPlayerNode):
	if position.x < otherPlayer["position"].x:
		otherPlayerNode.get_node("AnimationPlayer").play("Right")
	elif position.x > otherPlayer["position"].x:
		otherPlayerNode.get_node("AnimationPlayer").play("Left")
	elif position.y > otherPlayer["position"].y:
		otherPlayerNode.get_node("AnimationPlayer").play("Up")
	elif position.y < otherPlayer["position"].y:
		otherPlayerNode.get_node("AnimationPlayer").play("Down")
	else:
		otherPlayerNode.get_node("Sprite").set_frame(0)
		otherPlayerNode.get_node("AnimationPlayer").stop()

remote func receiverPlayerId(playerId):
	ownPlayerId = playerId
	
remote func receiveMove(allPlayers):
	for players in allPlayers:
		if str(players["playerId"]) != str(ownPlayerId):
			set_players_position(players)
	
remote func receivePlayers(players):
	var lastIndex = len(players)-1
	label.text = "Bienvenido jugador " + str(players[lastIndex]["playerId"])
	for player in players:
		if player["playerId"] != ownPlayerId:
			players_in_map.append({
				"playerId": player["playerId"],
				"position": player["position"],
				"group": "player" + str(player["playerId"])
			})
	for player in players_in_map:
		if !(player["group"] in groups):
			groups.append("player" + str(player["playerId"]))
			example_script.loadCharacter(player, playersOnlineNode)
