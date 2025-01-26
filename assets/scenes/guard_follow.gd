extends PathFollow2D
var guardSpeed = 0.1
func _process(delta):
	progress_ratio += delta * guardSpeed


func _on_guard_detect_body_entered(body: Node2D) -> void:
	if(body ==$"../../../Submarine"):
		Hub.take_damage.emit(30)
