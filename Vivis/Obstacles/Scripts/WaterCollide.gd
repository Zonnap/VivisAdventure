extends Area2D

# if Player character enters reload scene
func _on_body_entered(body):
	if body.name == "PlayerCharacter":
		get_tree().reload_current_scene()

func _process(delta):
	$AnimatedSprite2D.play("default")
