extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# if player character enters, give +1 snack and delete it
func _on_body_entered(body):
	if body.name == "PlayerCharacter":
		Global.fishSnacks += 1
		queue_free()
