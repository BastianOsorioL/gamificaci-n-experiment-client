extends Node

var message = 'hello'

func saludo(name):
	print('Hola ', name,', Bienvenido al juego')

func change_label(node):
	node.text = 'Texto cambiado por el script'

func loadCharacter(newPlayer, nodePlayersOnline):
	var newCharacter = preload("res://Scenes/Player.tscn").instance()
	newCharacter.name = newPlayer["group"]
	newCharacter.remove_from_group("Players")
	newCharacter.set_collision_layer_bit(1, true)	
	newCharacter.set_collision_layer_bit(2, true)
	newCharacter.add_to_group(newPlayer["group"])
	newCharacter.set_position(newPlayer["position"])
	nodePlayersOnline.add_child(newCharacter)
