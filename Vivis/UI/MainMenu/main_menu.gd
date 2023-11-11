extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://levels/PlayerTestingLevel.tscn")


func _on_settings_pressed():
#	var settings = load("res://UI/MainMenu/settings_menu.tscn").instance()
#	get_tree().current_scene.add_child(settings)
	pass


func _on_exit_pressed():
	get_tree().quit()
