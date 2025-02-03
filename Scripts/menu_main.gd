extends Control

func _on_button_play_pressed():
	TransitionRect.change_scene("res://Scenes/intro.tscn")

#TODO
#func _on_button_continue_pressed():
	#retrieve saved data
	#change scene to loaded scene

func _on_button_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_options.tscn")

#TODO
#func _on_button_credits_pressed():
	#get_tree().change_scene_to_file(--insert credits scene path--)
	
func _on_button_quit_pressed():
	get_tree().quit()
