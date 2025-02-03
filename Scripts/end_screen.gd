extends Node2D

var game = preload("res://Scenes/game.tscn").instantiate()

# test numbers
var incorrect_detains 

var incorrect_pass 

func set_incorrect_detains():
	incorrect_detains = Global.incorrect_detain.size()
	
func set_incorrect_pass():
	incorrect_pass = Global.incorrect_pass.size()
	
func set_text() -> String:
	var end_text = ""
	if (incorrect_detains == 0 && incorrect_pass == 0):
		$Control/ColorRect/TextureRect.texture = load("res://Art/Doc/end plate blue.png")
		end_text = "
		All is well as another peaceful day passes thanks to the hard work of our intergalactic security officers. 
		Congratulations!"
	elif (incorrect_detains > 0 && incorrect_pass == 0):
		$Control/ColorRect/TextureRect.texture = load("res://Art/Doc/end plate yellow.png")
		end_text = str("
		Tragedy struck last night as ", 
		incorrect_detains, " innocent travelers were detained at border control and have since gone missing.
		Tensions continue to rise as Officials from the involved Star-Sectors are starting to demand answers and punishment for those responsible for this mishap.")
	elif (incorrect_detains == 0 && incorrect_pass > 0):
		$Control/ColorRect/TextureRect.texture = load("res://Art/Doc/end plate yellow.png")
		end_text = str("
		Tragedy struck last night as ", 
		incorrect_pass, " suspicious travelers were seen passing through border control and continue to wreak havoc on local star systems.
		Enforcement officers have been deployed to deal with the situation, but no updates have been confirmed thus far")
	else:
		$Control/ColorRect/TextureRect.texture = load("res://Art/Doc/end plate yellow.png")
		end_text = str("
		Tragedy struck last night as ", 
		incorrect_detains, " suspicous travelers were detained at border control and have since gone missing.
		Tensions continue to rise as Officials from the involved Star-Sectors are starting to demand answers and punishment for those responsible for this mishap.
		In addition, ", incorrect_pass, " suspicious travelers were seen passing through border control and continue to wreak havoc on the local star systems.
		Enforcement officers have been deployed to deal with the situation, but no updates have been confirmed thus far")

	return end_text
# Called when the node enters the scene tree for the first time.
func _ready():
	set_incorrect_detains()
	set_incorrect_pass()
	$Control/ColorRect/TextureRect/RichTextLabel.text = set_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
