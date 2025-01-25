extends Node3D

@export var bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar = $SubViewport/ProgressBar
	bar.max_value = Hub.hull_health_max
	bar.value = Hub.hull_health
