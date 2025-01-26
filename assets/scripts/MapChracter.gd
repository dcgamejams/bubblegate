extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var speed = 0
#@export var friction = 0.015
#@export var acceleration = 0.1

var speed_current_index = 0
var speed_array = [0, 2, 4, 8, 10, 12]

var is_sub = true

func _ready():
	Hub.increase_speed.connect(_on_increase_speed)
	Hub.decrease_speed.connect(_on_decrease_speed)
	Hub.SubmarinePlayer = self

func _on_increase_speed():
	if speed_current_index + 1 <= 5:
		speed_current_index = speed_current_index + 1
		speed = speed_array[speed_current_index]
		Hub.power_label.text = str(speed_array[speed_current_index])

func _on_decrease_speed():
	if speed_current_index - 1 >= 0:
		speed_current_index = speed_current_index - 1
		speed = speed_array[speed_current_index]
		Hub.power_label.text = str(speed_array[speed_current_index])
		
func _hit_wall():
	Hub.take_damage.emit(5)

##############
##############
##############
##############
##############



@export var steering_angle = 45  # Maximum angle for steering the car's wheels
@export var engine_power = 10  # How much force the engine can apply for acceleration
@export var friction = -15  # The friction coefficient that slows down the car
@export var drag = -0.02  # Air drag coefficient that also slows down the car
@export var braking = -450  # Braking power when the brake input is applied
@export var max_speed_reverse = 2  # Maximum speed limit in reverse
@export var slip_speed = 400  # Speed above which the car's traction decreases (for drifting)

var wheel_base = 8  # Distance between the front and back axle of the car
var acceleration = Vector2.ZERO  # Current acceleration vector
var steer_direction  # Current direction of steering

@export var is_active = true

func _physics_process(delta: float) -> void:
	if is_active:
		acceleration = Vector2.ZERO
		get_input()  # Take input from player
		calculate_steering(delta)  # Apply turning logic based on steering

	velocity += acceleration * delta  # Apply the resulting acceleration to the velocity
	apply_friction(delta)  # Apply friction forces to the car
	move_and_slide()  # Move the car and handle collisions
	

#function to handle input from the user and apply effects to the car's movement
func get_input():
	# Get steering input and translate it to an angle
	var turn = Input.get_axis("ui_left", "ui_right")
	steer_direction = turn * deg_to_rad(steering_angle)

	# If accelerate is pressed, apply engine power to the car's forward direction
	#if Input.is_action_pressed("ui_up"):
	acceleration = transform.x * speed

	# If brake is pressed, apply braking force
	if Input.is_action_pressed("ui_down"):
		acceleration = transform.x * braking

#Function to apply friction forces to the car, making it 'slide' to a halt
func apply_friction(delta):
	# If there is no input and speed is very low, just stop to prevent endless sliding
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	# Calculate friction force and air drag based on current velocity, and apply it
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	# Add the forces to the acceleration
	acceleration += drag_force + friction_force

	
# Function to calculate the steering effect
func calculate_steering(delta):
	# Calculate the positions of the rear and front wheel
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	# Advance the wheels' positions based on the current velocity, applying rotation to the front wheel
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	# Calculate the new heading based on the wheels' positions
	var new_heading = rear_wheel.direction_to(front_wheel)

	# Choose the traction model based on the current speed


	# Dot product represents how aligned the new heading is with the current velocity direction
	var d = new_heading.dot(velocity.normalized())

	# If not braking (d > 0), adjust the car velocity smoothly towards the new heading
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), delta)

	# If braking (d < 0), reverse the direction and limit the speed
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)

	# Update the car's rotation to face in the direction of the new heading
	rotation = new_heading.angle()
