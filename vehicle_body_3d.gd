extends VehicleBody3D

var max_RPM = 600
var max_torque = 1500
var turn_speed = 3
var turn_amount = 0.3

func _physics_process(delta: float) -> void:
	$CamArm.position = position
	
	var dir = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steering_dir = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	
	var RPM_left = abs($WheelBL.get_rpm())
	var RPM_right = abs($WheelBR.get_rpm())
	var RPM = (RPM_left + RPM_right) / 2
	
	var torque = dir * max_torque * (1.0 - RPM / max_RPM)
	
	engine_force = torque
	steering = lerp(steering, steering_dir * turn_amount, turn_speed * delta)
	
	if dir == 0:
		brake = 2
