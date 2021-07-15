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
onready var Joystick = get_tree().get_root().get_node("World/Joystick")

func _ready():
	transition_to(IDLE)
	
func _physics_process(delta):
	if self.is_in_group("Players"):
		actualPosition = self.get_position()
		if current_animation != new_animation:
			current_animation = new_animation
			$AnimationPlayer.play(current_animation)
			
		velocity.y = 0
		velocity.x = 0
		
		if Input.is_action_pressed("ui_right") || Joystick.right_pressed:
			velocity.x += speed
		if Input.is_action_pressed("ui_left") || Joystick.left_pressed:
			velocity.x -= speed
		if Input.is_action_pressed("ui_down") || Joystick.down_pressed:
			velocity.y += speed
		if Input.is_action_pressed("ui_up") || Joystick.up_pressed:
			velocity.y -= speed
		
		idle_to_state()
		state_to_idle()
		down_to_state()
		up_to_state()
		right_to_state()
		left_to_state()
		
		RpcNode.send_move()
		
		velocity.y += gravity * delta
		move_and_slide_with_snap(velocity,Vector2(0,-1))
		
func idle_to_state():
	if state == IDLE and velocity.x > 0:
		transition_to(RIGHT)
	elif state == IDLE and velocity.x < 0:
		transition_to(LEFT)
	elif state == IDLE and velocity.y > 0:
		transition_to(DOWN)
	elif state == IDLE and velocity.y < 0:
		transition_to(UP)
		
func state_to_idle():
	if state == DOWN and velocity == Vector2(0,0):
		transition_to(IDLE)
	elif state == RIGHT and velocity == Vector2(0,0):
		transition_to(IDLE)
	elif state == LEFT and velocity == Vector2(0,0):
		transition_to(IDLE)
	elif state == UP and velocity == Vector2(0,0):
		transition_to(IDLE)
		
func up_to_state():
	if state == UP and velocity.x > 0:
		transition_to(RIGHT)
	elif state == UP and velocity.x < 0:
		transition_to(LEFT)
		
func down_to_state():
	if state == DOWN and velocity.x > 0:
		transition_to(RIGHT)
	elif state == DOWN and velocity.x < 0:
		transition_to(LEFT)
		
func right_to_state():
	if state == RIGHT and velocity.y < 0 and velocity.x == 0:
		transition_to(UP)
	if state == RIGHT and velocity.y > 0 and velocity.x == 0:
		transition_to(DOWN)

func left_to_state():
	if state == LEFT and velocity.y < 0 and velocity.x == 0:
		transition_to(UP)
	if state == LEFT and velocity.y > 0 and velocity.x == 0:
		transition_to(DOWN)

func transition_to(new_state):
	state = new_state
	match state:
		IDLE:
			$Sprite.set_frame(0)
			$AnimationPlayer.stop()
		RIGHT:
			new_animation = "Right"
		LEFT:
			new_animation = "Left"
		DOWN:
			new_animation = "Down"
		UP:
			new_animation = "Up"
