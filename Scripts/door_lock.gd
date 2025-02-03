extends Control

@onready var lockButton: TextureButton = self.get_child(0)
@onready var unlockButton: TextureButton = self.get_child(1)

@onready var is_door_locked: bool = true

func _on_door_lock_button_pressed():
	$lock_button.disabled = true
	$unlock_button.disabled = false
	
	is_door_locked = true
	print("door_locked")
	
	#var alien = get_node("../alien").get_child(0).get_child(0).get_child(0)
	#alien.alienStop()
#
func _on_door_unlock_button_pressed():
	$unlock_button.disabled = true
	$lock_button.disabled = false
	
	is_door_locked = false
	print("door_unlocked")
	
	#var alien = get_node("../alien").get_child(0).get_child(0).get_child(0)
	#alien._process(get_process_delta_time())
