extends CharacterBody2D
@onready var target = $"../../Submarine"
var speed = 50
#@onready retreat = $"../GuardPath/GuardFollow/GuardDetect"

@onready var nav: NavigationAgent2D = $NavigationAgent2D
var is_sub = false
func _physics_process(delta):
	var direction = Vector3 ()
	nav.target_position = target.position
	direction = (nav.get_next_path_position() - global_position)
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, delta)
	move_and_slide()





func _on_chase_h_box_body_entered(body: Node2D) -> void:
	if(body ==$"../../Submarine"):
		Hub.take_damage.emit(30)
		#target = $"../GuardPath/GuardFollow/GuardDetect"
