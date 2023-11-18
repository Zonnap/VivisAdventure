extends CharacterBody2D

signal health_updated()

var health = 0
var maxHealth = 3
var isDead = false

const SPEED = 200.0
const JUMP_VELOCITY = -350
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var anim = get_node("AnimationPlayer") #Get animation player on startup and make it a variable
@onready var timer = $Timer

func _ready():
	health = maxHealth

# Delta Time
func _physics_process(delta):
	
	# -------------------------------------------------------- # Add the gravity.
	
	if not is_on_floor():
		timer.start()
		velocity.y += gravity * delta
		
	# -------------------------------------------------------- X
	# -------------------------------------------------------- Handle Jump.
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		pass
		
	
	if not is_on_floor():
		if velocity.y < 0:# Jump and fall animations
			anim.play("Jump")
		else:
			anim.play("Fall")
			
	# -------------------------------------------------------- X
	# -------------------------------------------------------- Movement
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip sprtie to velocity direction
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	# Move depending in direction vbalue
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	# Enables movement and physics of player
	move_and_slide()
	# -------------------------------------------------------- X
# -------------------------------------------------------- Player Health and Damage

func _process(_delta):
	if isDead == true:
		get_tree().change_scene_to_file("res://UI/DeathScreen/DeathScreen.tscn")
	
func _on_thorn_body_entered(body):
	print(body)
	if  body.name == "PlayerCharacter":
		health -= 1
		print(health)
	if health <= 0:
		health = 0
		isDead = true
		_process(get_process_delta_time())
	if health > maxHealth:
		health = maxHealth
# -------------------------------------------------------- X
# -------------------------------------------------------- Fish Snacks

func _on_fish_snacks_body_entered(body):
	pass
