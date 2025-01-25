extends Area2D
var speed = 1
var playerPos
var targetPos
@onready var player = get_parent().get_node("Submarine")

func _physics_process(delta: float) -> void:
	playerPos = player.Position
	targetPos = (playerPos-position).normalized()
	
	if(position.distance_to(playerPos)>3):
		position += targetPos * speed * delta
	
