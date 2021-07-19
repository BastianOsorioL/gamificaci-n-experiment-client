extends KinematicBody2D

var speed = 150
var velocity = Vector2(0,0)
var gravity : float
var actualPosition

enum{IDLE, RIGHT, LEFT, DOWN, UP}

var state
var current_animation
var new_animation

onready var RpcNode = get_tree().get_root().get_node("World/RPCClient")
onready var dPad = get_tree().get_root().get_node("World/DPad")
onready var playerNode = get_tree().get_root().get_node("World/Player")
var change_state_script = preload("res://Scripts/state/change_state.gd").new()

func _ready():
	transition_to('IDLE')
	
func _physics_process(delta):
	if self.is_in_group("Players"):
		actualPosition = self.get_position()
		if state != 'IDLE':
			current_animation = new_animation
			$AnimationPlayer.play(current_animation)
			
		velocity.y = 0
		velocity.x = 0
		
		if Input.is_action_pressed("ui_right") || dPad.right_pressed:
			velocity.x += speed
			
		if Input.is_action_pressed("ui_left") || dPad.left_pressed:
			velocity.x -= speed

		if Input.is_action_pressed("ui_down") || dPad.down_pressed:
			velocity.y += speed
			
		if Input.is_action_pressed("ui_up") || dPad.up_pressed:
			velocity.y -= speed
		
		change_state_script.idle_to_state(state, velocity, playerNode)
		change_state_script.state_to_idle(state, velocity, playerNode)
		change_state_script.down_to_state(state, velocity, playerNode)
		change_state_script.up_to_state(state, velocity, playerNode)
		change_state_script.right_to_state(state, velocity, playerNode)
		change_state_script.left_to_state(state, velocity, playerNode)
		
		RpcNode.send_move()
		
		velocity.y += gravity * delta
		move_and_slide_with_snap(velocity,Vector2(0,-1))

func transition_to(new_state):
	state = new_state
	match state:
		'IDLE':
			$Sprite.set_frame(0)
			$AnimationPlayer.stop()
		'RIGHT':
			new_animation = "Right"
		'LEFT':
			new_animation = "Left"
		'DOWN':
			new_animation = "Down"
		'UP':
			new_animation = "Up"
