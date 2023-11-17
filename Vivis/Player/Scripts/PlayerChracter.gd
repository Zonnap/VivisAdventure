extends CharacterBody2D

signal health_updated()

var health = 0
var maxHealth = 3
var isDead = false

const SPEED = 200.0
const JUMP_VELOCITY = -350
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var anim = get_node("AnimationPlayer") #Get animation player on startup and make it a variable


# Delta Time
func _physics_process(delta):
	
	# -------------------------------------------------------- # Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# -------------------------------------------------------- X
	# -------------------------------------------------------- Handle Jump.
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		pass
	
	# Jump and fall animations
	if not is_on_floor():
		if velocity.y < 0:
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

func _ready():
	health = maxHealth

func _process(delta):
	if isDead == true:
		get_tree().change_scene_to_file("res://UI/DeathScreen/DeathScreen.tscn")
	

#func _on_area_2d_body_entered(body):
#	if  body.name == "Thorn":
#		health -= 1
#		print(health)
#	if health <= 0:
#		health = 0
#		isDead = true
#	if health > maxHealth:
#		health = maxHealth
	
