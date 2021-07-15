extends CanvasLayer

var up_pressed = false
var right_pressed = false
var left_pressed = false
var down_pressed = false

func _on_Up_pressed():
	up_pressed = true

func _on_Right_pressed():
	right_pressed = true

func _on_Left_pressed():
	left_pressed = true

func _on_Down_pressed():
	down_pressed = true

func _on_Up_released():
	up_pressed = false

func _on_Right_released():
	right_pressed = false

func _on_Left_released():
	left_pressed = false

func _on_Down_released():
	down_pressed = false
