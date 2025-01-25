extends CharacterBody2D
@onready var target = $"../../Submarine"
var speed = 10
func _physics_process(delta: float):
	var direction = (target.position - position).normalized()
	velocity = direction * speed
	look_at(target.position)
	move_and_slide()
