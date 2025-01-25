extends PathFollow2D
var guardSpeed = 0.1
func _process(delta):
	progress_ratio += delta * guardSpeed
