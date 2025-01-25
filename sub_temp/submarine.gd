extends Node3D
var can_ping: bool
var sonar_radius: bool
var is_pinging: bool
var hit_bottom: bool
var wait_time_between_pings := 10
var ping_duration := 5
var timer_ping_last := Timer.new()
var timer_ping_cooldown := Timer.new()
var neighboring_entities=[]
signal PING_START
signal PING_STOP
signal PING_REGISTER(entity)
func _stop_ping() ->void:
	if is_pinging:
		is_pinging=false
		PING_STOP.emit()
func _reset_ping_cooldown() ->void:
	can_ping=true

func _init():
	transform.origin=Vector3.ZERO
	transform.basis=Basis.IDENTITY
	timer_ping_last.wait_time = ping_duration
	timer_ping_last.one_shot = true
	timer_ping_last.connect("timeout", _stop_ping)
	timer_ping_last.wait_time = wait_time_between_pings
	timer_ping_last.one_shot = true
	timer_ping_last.connect("timeout", _reset_ping_cooldown)
	PING_REGISTER.connect(_ping_register)
func _steer_right_left(delta):
	transform.basis=transform.basis.rotated(Vector3.UP,delta)
func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var end = transform.origin + Vector3.DOWN * 100.0
	var query = PhysicsRayQueryParameters3D.create(transform.origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result:
		hit_bottom=true
	else:
		hit_bottom=false
	
func _steer_up_down(delta):
	if delta<0.0 and hit_bottom:
		return
	transform.origin-=Vector3.DOWN*delta
func _send_ping():
	if can_ping:
		PING_START.emit()
		can_ping=false
		is_pinging=true
	else:
		return
func _ping_register(entity):
	if (entity.transform.origin-transform.origin).length<sonar_radius and is_pinging:
		neighboring_entities.append(entity)

	
	
