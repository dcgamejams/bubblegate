extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Hub.Map = $EnvironmentContainer/Map
	Hub.Sub = $EnvironmentContainer/Sub
	Hub.HullMonitor = $EnvironmentContainer/HullMonitor
	Hub.Terminal = $EnvironmentContainer/Terminal3dEmbed
	Hub.sound_container = $SoundContainer
