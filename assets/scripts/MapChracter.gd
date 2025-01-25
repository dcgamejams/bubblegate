extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var speed = 200
@export var friction = 0.05
@export var acceleration = 0.1

func get_input():
	var input = Vector2()
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func _on_enemy_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
