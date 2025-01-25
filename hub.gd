# This is a "global" autoload that helps with coordination
extends Node


signal decrease_speed
signal increase_speed

signal take_damage

var environment_container: Node3D
var players_container: Node3D

var Map: Node2D
var Sub: Node3D
var HullMonitor: Node3D
var Terminal: Node3D

var speed = 0.0
var depth = 100.0

var hull_health_max = 100
var hull_health = 100

var interact_timer := Timer.new()

func _ready():
	add_child(interact_timer)
	interact_timer.wait_time = 0.4
	interact_timer.one_shot = true
	
	take_damage.connect(_on_take_damage)
	
func interact(interact_event):
	if Hub.hull_health <= 0:
		return
		
	if interact_timer.is_stopped() == false:
		return

	interact_timer.start()
	#print('DEBUG: interact_event: ', interact_event)
	match interact_event:
		"PowerDown":
			decrease_speed.emit()
		"PowerUp":
			increase_speed.emit()
		"Map":
			if Map.is_map_visible == false:
				Map.map_show()
			else:
				Map.map_hide()

func _on_take_damage(damage): 
	if hull_health - damage > 0:
		hull_health = hull_health - damage
		HullMonitor.bar.value = hull_health
	else:
		hull_health = 0
		HullMonitor.bar.value = hull_health
		speed = 0
