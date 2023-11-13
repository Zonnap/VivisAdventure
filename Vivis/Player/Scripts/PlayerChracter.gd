extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300
var extraJump = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	
	# -------------------------------------------------------- # Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# -------------------------------------------------------- X
	# -------------------------------------------------------- Handle Jump.
	
	if Input.is_action_just_pressed("jump") && extraJump >= 1:
		extraJump -= 1
		velocity.y = JUMP_VELOCITY
	else:
		pass
	print(extraJump)
	if is_on_floor():
		extraJump = 1
	
	if not is_on_floor():
		if velocity.y < 0:
			anim.play("Jump")
		else:
			anim.play("Fall")
			
	# -------------------------------------------------------- X
	# -------------------------------------------------------- Movement
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	move_and_slide()
	# -------------------------------------------------------- X
