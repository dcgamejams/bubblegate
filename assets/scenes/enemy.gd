extends CharacterBody2D
@onready var target = $"../../Submarine"
var targetPos


var speed = 50

func _physics_process(delta): 
	
	var direction = (target.position - position).normalized()
	
	velocity = direction * speed
	
	
	move_and_slide()
