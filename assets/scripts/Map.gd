extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_treasure_body_entered(body: Node2D) -> void:
	$Terminal.text = 'picture of atlantis'
	pass # Replace with function body.


func _on_enemy_body_entered(body: Node2D) -> void:
	$Terminal.text = 'YOU HIT Enemy'
	pass # Replace with function body.
