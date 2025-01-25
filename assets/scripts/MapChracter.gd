extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var speed = 25
@export var friction = 0.015
@export var acceleration = 0.1

var speed_current_index = 0
var speed_array = [15, 35, 75, 100]

func _ready():
	Hub.increase_speed.connect(_on_increase_speed)
	Hub.decrease_speed.connect(_on_decrease_speed)

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
	if get_parent().is_map_visible == false:
		return

	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()

func _on_increase_speed():
	if speed_current_index + 1 <= 4:
		speed_current_index = speed_current_index + 1
		speed = speed_array[speed_current_index]

func _on_decrease_speed():
	if speed_current_index - 1 >= 0:
		speed_current_index = speed_current_index - 1
		speed = speed_array[speed_current_index]
		
func _hit_wall():
	Hub.take_damage.emit(5)
