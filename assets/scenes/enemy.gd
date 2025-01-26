extends CharacterBody2D
@onready var target = $"../../Submarine"
var speed = 0
#@onready retreat = $"../GuardPath/GuardFollow/GuardDetect"

var is_retreating = false

@onready var nav: NavigationAgent2D = $NavigationAgent2D
var is_sub = false
func _physics_process(delta):
	# Cant chase if you aren't in the Map
	if $"../../Submarine/SubCamera".enabled == false && is_retreating == false:
		speed = 5
	var direction = Vector3 ()
	nav.target_position = target.position
	direction = (nav.get_next_path_position() - global_position)
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, delta)
	move_and_slide()


# retreat
func _on_chase_h_box_body_entered(body: Node2D) -> void:
	if(body ==$"../../Submarine"):
		Hub.take_damage.emit(17)
		$FishNoise.play()
		target = $"../../RetreatMarkerForEnemy"
		speed = 250
		is_retreating = true
		

	
# chase
func _on_picture_of_atlantis_body_entered(body: Node2D) -> void:
	speed = 50
	target = $"../../Submarine"

# start chasing again
func _on_retreat_location_body_entered(body: Node2D) -> void:
	speed = 50
	target = $"../../Submarine"
	is_retreating = false
