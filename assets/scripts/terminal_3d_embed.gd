extends Node3D

var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = 	$SubViewport/TerminalUI/Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
