extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func esc_action():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		self.visible = true
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		self.visible = false
		resume()
		
func _on_buttom__resume_pressed():
	self.visible = false
	resume()

func _on_button_restart_pressed():
	self.visible = false
	resume()
	get_tree().reload_current_scene()


func _on_button_quit_pressed():
	get_tree().quit()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	esc_action()
