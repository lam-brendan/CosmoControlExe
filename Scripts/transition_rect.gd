extends CanvasLayer

func change_scene(next_scene) -> void:
	$AnimationPlayer.play("Fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(next_scene)
	$AnimationPlayer.play_backwards("Fade")
