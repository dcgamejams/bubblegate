extends Node2D

var interact_timer := Timer.new()

var is_map_visible = false

func _ready():
	hide()

func map_hide():
	if Hub.interact_timer.is_stopped():
		Hub.interact_timer.start()
		is_map_visible = false
		hide()
	
func map_show():
	if Hub.interact_timer.is_stopped():
		Hub.interact_timer.start()
		is_map_visible = true
		show()
		

func _on_enemy_body_entered(body: CharacterBody2D) -> void:
	$Terminal.text = 'YOU HIT Enemy'
	pass # Replace with function body.

# Text to go to terminal once player reaches a point of interest 
func _on_treasure_body_entered(body: CharacterBody2D) -> void:
	if body.is_sub: 
		$Terminal.text = 'You come across an old stone. Etched into the stone is a ' 
		$Terminal.text += '\ndrawing of a luxurious city protected from the flooded '
		$Terminal.text += '\nworld by a massive bubble dome. Outside of the dome, an'
		$Terminal.text += '\nunkown creature with massive tentacles, and sharp teeth, '
		$Terminal.text += '\ncircles the bubble. Above the drawing, four large boxes '
		$Terminal.text += '\nhave been scratched into the stone. It looks like it '
		$Terminal.text += '\nused to say something.'
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.

func _on_rune_1_body_entered(body: CharacterBody2D) -> void:
	if body.is_sub: 	
		$Terminal.text = 'You enter a cave that is covered wall to wall by '
		$Terminal.text = 'You enter a cave that is covered wall to wall by '
		$Terminal.text += '\none repeating symbol. DESCRIBE THE RUNE'
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.

func _on_rune_2_body_entered(body: CharacterBody2D) -> void:
	if body.is_sub: 	
		$Terminal.text = 'You enter a cave that is covered wall to wall by '
		$Terminal.text = 'In a large open area you come across a large pillar. '
		$Terminal.text += '\nAt the top of the pillar, partially covered by kelp, '
		$Terminal.text += '\n you can just about makeout a shape that can only be '
		$Terminal.text += '\n described as DESCRIBE RUNE'
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.

func _on_rune_3_body_entered(body: Node2D) -> void:
	# DO NOT REMOVE
	if body.has_method('_on_increase_speed') == false: 
		return
	if body.is_sub: 
		$Terminal.text = 'You enter a cave that is covered wall to wall by '
		$Terminal.text = 'Up against a large rock wall someone appears to have '
		$Terminal.text += '\n carved a DESCRIBE RUNE'
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.

func _on_rune_4_body_entered(body: CharacterBody2D) -> void:
	if body.is_sub: 	
		$Terminal.text = 'You enter a cave that is covered wall to wall by '
		$Terminal.text = 'At the back of a cave, you discover the remains of a '
		$Terminal.text += '\n ship hull. A rotted skeleton greats you from the corner. '
		$Terminal.text +=  '\n behind it, a DESCRIBE RUNE has been painted on the wall.'
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.


# Atlantis door 
func _on_atlantis_door_prompt_body_entered(body: CharacterBody2D) -> void:
	if body.is_sub: 	
		$Terminal.text = 'Ask for runes PLACEHOLDER'
		#if correct runes 
		#get rid of wall
		#else ask them to try again
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.


func _on_atlantis_door_prompt_2_body_entered(body: Node2D) -> void:
	if body.is_sub: 	
		$Terminal.text = 'Ask for runes PLACEHOLDER'
		#if correct runes 
		#get rid of wall
		#else ask them to try again
		Hub.show_new_text($Terminal.text)
		pass # Replace with function body.
