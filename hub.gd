# This is a "global" autoload that helps with coordination
extends Node


signal decrease_speed
signal increase_speed

signal take_damage

var environment_container: Node3D
var players_container: Node3D
var sound_container: Node3D

var Map: Node2D
var Sub: Node3D
var HullMonitor: Node3D
var Terminal: Node3D

var SubmarinePlayer: CharacterBody2D

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
		"Repair":
			_on_repair(4)
			
func _on_repair(health): 
	if hull_health + health <= 100:
		hull_health = hull_health + health
		HullMonitor.bar.value = hull_health
	else:
		hull_health = 100
		HullMonitor.bar.value = hull_health

func _on_take_damage(damage): 
	if hull_health - damage > 0:
		hull_health = hull_health - damage
		HullMonitor.bar.value = hull_health
	else:
		hull_health = 0
		HullMonitor.bar.value = hull_health
		speed = 0
		show_new_text('CRITICAL DAMAGE GAME OVER')

func show_new_text(_new_text): 
	Terminal.label.text = _new_text

func play_sound(_name):
	var found_sound: AudioStreamPlayer3D
	for sound in sound_container.get_children():
		if sound.name == _name:
			found_sound = sound
			found_sound.play()
