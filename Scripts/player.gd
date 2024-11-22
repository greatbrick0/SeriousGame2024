extends CharacterBody3D

const SPEED = 5.0
var mouseLocked: bool = true

func _ready():
	HudManager.playerRef = self
	HudManager.SetMouseLocked(true)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if(mouseLocked):
		var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		move_and_slide()
	
	if(mouseLocked and $Camera/RayCast3D.is_colliding()):
		HudManager.hoverText = $Camera/RayCast3D.get_collider().hoverText
		if(Input.is_action_just_pressed("Interact")):
			$Camera/RayCast3D.get_collider().Activate()
	else:
		HudManager.hoverText = ""

func _input(event):
	if event is InputEventMouseMotion:
		if(mouseLocked):
			rotate_y(-event.relative.x * 0.003)
			$Camera.rotate_x(-event.relative.y * 0.003)
			$Camera.rotation.x = clampf($Camera.rotation.x, -PI * 0.45, PI * 0.45)
