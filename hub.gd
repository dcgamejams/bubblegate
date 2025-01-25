# This is a "global" autoload that helps with coordination
extends Node

var environment_container: Node3D
var players_container: Node3D


var terminal_label: Label3D


var has_key_one = false

var speed = 0.0
var depth = 100.0

var interact_timer := Timer.new()

func _ready():
	add_child(interact_timer)
	interact_timer.wait_time = 0.8
	interact_timer.one_shot = true

func interact(interact_event):
	if interact_timer.is_stopped() == false:
		return

	interact_timer.start()
	#print('DEBUG: interact_event: ', interact_event)
	match interact_event:
		"PowerDown":
			print("POWER DOWN!!")
		"PowerUp":
			print("POWER up fast happens!!")
			

func send_text_to_terminal(label_text):
	terminal_label.text = label_text
	
	
