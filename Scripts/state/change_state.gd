extends Node

func idle_to_state(state, velocity, nodePlayer):
	if state == 'IDLE' and velocity.x > 0:
		nodePlayer.transition_to('RIGHT')
	elif state == 'IDLE' and velocity.x < 0:
		nodePlayer.transition_to('LEFT')
	elif state == 'IDLE' and velocity.y > 0:
		nodePlayer.transition_to('DOWN')
	elif state == 'IDLE' and velocity.y < 0:
		nodePlayer.transition_to('UP')

func state_to_idle(state, velocity, nodePlayer):
	if state == 'DOWN' and velocity == Vector2(0,0):
		nodePlayer.transition_to('IDLE')
	elif state == 'RIGHT' and velocity == Vector2(0,0):
		nodePlayer.transition_to('IDLE')
	elif state == 'LEFT' and velocity == Vector2(0,0):
		nodePlayer.transition_to('IDLE')
	elif state == 'UP' and velocity == Vector2(0,0):
		nodePlayer.transition_to('IDLE')
		
func up_to_state(state, velocity, nodePlayer):
	if state == 'UP' and velocity.x > 0:
		print('up_to_state')
	elif state == 'UP' and velocity.x < 0:
		nodePlayer.transition_to('LEFT')
		
func down_to_state(state, velocity, nodePlayer):
	if state == 'DOWN' and velocity.x > 0:
		nodePlayer.transition_to('RIGHT')
	elif state == 'DOWN' and velocity.x < 0:
		nodePlayer.transition_to('LEFT')
		
func right_to_state(state, velocity, nodePlayer):
	if state == 'RIGHT' and velocity.y < 0 and velocity.x == 0:
		nodePlayer.transition_to('UP')
	if state == 'RIGHT' and velocity.y > 0 and velocity.x == 0:
		nodePlayer.transition_to('DOWN')

func left_to_state(state, velocity, nodePlayer):
	if state == 'LEFT' and velocity.y < 0 and velocity.x == 0:
		nodePlayer.transition_to('UP')
	if state == 'LEFT' and velocity.y > 0 and velocity.x == 0:
		nodePlayer.transition_to('DOWN')
