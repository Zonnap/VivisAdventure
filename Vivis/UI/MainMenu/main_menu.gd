extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
		$Node2D/AnimationPlayer.play("Text_Animation")

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://levels/DO NOT USE OR DELETE/forest.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenu/settings_menu.tscn")
	


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenu/Credits.tscn")
