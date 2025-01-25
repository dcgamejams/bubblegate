extends MeshInstance3D
var t=0
var debug_objects=false
var points=[]
var sonar_radius=0.0
signal register_with_sonar(xy, radius)

func _register_with_sonar_callback(origin: Vector2, scale: float):
	var xy=Vector3(origin.x,
				origin.y, 
				scale)
	var xy2=Vector3(transform.origin.x,
				transform.origin.y,
				(transform.basis*Vector3.FORWARD).length())
	var xyz=Vector3(xy.x-xy2.x,xy.y-xy2.y,xy.z/xy2.z)
	if len(points)+1>256:
		points.remove_at(0)
	points.append(xyz)
	print(xyz)
func _init():
	register_with_sonar.connect(_register_with_sonar_callback)
			
			
func _process(dt):
	var rng = RandomNumberGenerator.new()
	if debug_objects:
		for i in range(40):
			var random_pos = Vector2(transform.origin.x,transform.origin.y) + Vector2(rng.randf()*2.0-1.0, rng.randf()*2.0-1.0)
			register_with_sonar.emit(random_pos, rng.randf()*0.01)
	
	var uniform_array=[]
	for i in range(256):
		if i<len(points):
			uniform_array.append(points[i])
		else:
			uniform_array.append(Vector3.ZERO)
	get_surface_override_material(1).set_shader_parameter("time_mod_1s", t+dt)
	var array=PackedVector3Array(uniform_array)
	print(len(array))
	get_surface_override_material(1).set_shader_parameter("points", array)
	t+=dt
	print(t)
