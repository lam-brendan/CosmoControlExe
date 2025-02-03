extends Node2D

var current_page_l
var current_page_r

var current_page_l_instance
var current_page_r_instance

#Path to pages for access
var dict_pages = {
	1: "res://Scenes/Manual/Pages/page_1.tscn",
	2: "res://Scenes/Manual/Pages/page_2.tscn",
	3: "res://Scenes/Manual/Pages/page_3.tscn",
	4: "res://Scenes/Manual/Pages/page_4.tscn",
	5: "res://Scenes/Manual/Pages/page_5.tscn",
	6: "res://Scenes/Manual/Pages/page_6.tscn",
	7: "res://Scenes/Manual/Pages/page_7.tscn",
	8: "res://Scenes/Manual/Pages/page_8.tscn",
	9: "res://Scenes/Manual/Pages/page_9.tscn",
	10: "res://Scenes/Manual/Pages/page_10.tscn",
	11: "res://Scenes/Manual/Pages/page_11.tscn",
	12: "res://Scenes/Manual/Pages/page_12.tscn",
	13: "res://Scenes/Manual/Pages/page_13.tscn",
	14: "res://Scenes/Manual/Pages/page_14.tscn",
	15: "res://Scenes/Manual/Pages/page_15.tscn",
	16: "res://Scenes/Manual/Pages/page_16.tscn",
	17: "res://Scenes/Manual/Pages/page_17.tscn",
	18: "res://Scenes/Manual/Pages/page_18.tscn",
	19: "res://Scenes/Manual/Pages/page_19.tscn",
	20: "res://Scenes/Manual/Pages/page_20.tscn",
	21: "res://Scenes/Manual/Pages/page_21.tscn",
	22: "res://Scenes/Manual/Pages/page_22.tscn",
	23: "res://Scenes/Manual/Pages/page_23.tscn",
	24: "res://Scenes/Manual/Pages/page_24.tscn",
	25: "res://Scenes/Manual/Pages/page_25.tscn",
	26: "res://Scenes/Manual/Pages/page_26.tscn",
	27: "res://Scenes/Manual/Pages/page_27.tscn",
	28: "res://Scenes/Manual/Pages/page_28.tscn",
	29: "res://Scenes/Manual/Pages/page_29.tscn",
	30: "res://Scenes/Manual/Pages/page_30.tscn",
	31: "res://Scenes/Manual/Pages/page_31.tscn",
	32: "res://Scenes/Manual/Pages/page_32.tscn",
	33: "res://Scenes/Manual/Pages/page_33.tscn",
	34: "res://Scenes/Manual/Pages/page_34.tscn",
	35: "res://Scenes/Manual/Pages/page_35.tscn",
	36: "res://Scenes/Manual/Pages/page_36.tscn",
	37: "res://Scenes/Manual/Pages/page_37.tscn",
	38: "res://Scenes/Manual/Pages/page_38.tscn",
	39: "res://Scenes/Manual/Pages/page_39.tscn",
	40: "res://Scenes/Manual/Pages/page_40.tscn",
	41: "res://Scenes/Manual/Pages/page_41.tscn",
	42: "res://Scenes/Manual/Pages/page_42.tscn",
}

var page_max = dict_pages.size()	#For recording the max amount of pages

#Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = false
	
	current_page_l = 1
	current_page_r = 2
	
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/NextPage.pressed.connect(_next_page)
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PreviousPage.pressed.connect(_prev_page)
	
	$Control/Background/Exit.pressed.connect(_close)
	
	$Control/Background/home.pressed.connect(_home)
	
# Page forwards
func _next_page():
	print("Next Page Pressed")
	print("Old Left: " , current_page_l)
	print("Old Right: ", current_page_r)
	if current_page_r == 2:
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer/Page1.hide()
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer/Page2.hide()
		current_page_l = current_page_l + 2
		current_page_r = current_page_r + 2
		leave_toc()
	elif current_page_r != page_max:
		current_page_l = current_page_l + 2
		current_page_r = current_page_r + 2
		update_page()

# Page backwards
func _prev_page():
	print("Previous Page Pressed")
	print("Old Left: " , current_page_l)
	print("Old Right: ", current_page_r)
	if current_page_l == 3:
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer/Page1.show()
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer/Page2.show()
		current_page_l = current_page_l - 2
		current_page_r = current_page_r - 2
		enter_toc()
	if current_page_l != 1:
		current_page_l = current_page_l - 2
		current_page_r = current_page_r - 2
		update_page()

# close the manual
func _close():
	$Control.visible = false
	

#Updates pages and updates them based on the current page values according to the dictionary
func update_page():
	print("Updating Pages!")
	
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer/Page1.hide()
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer/Page2.hide()
	
	var left = $Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.get_child(1)
	var right = $Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.get_child(1)

	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.remove_child(left)
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.remove_child(right)
	
	var new_left = load(dict_pages[current_page_l]).instantiate()
	var new_right = load(dict_pages[current_page_r]).instantiate()
	
	print("New Left: " , current_page_l)
	print("New Right: ", current_page_r)
	print("")
	
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.add_child(new_left)
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.add_child(new_right)
	
	print("Finished updating pages")

func leave_toc():
	var new_left = load(dict_pages[current_page_l]).instantiate()
	var new_right = load(dict_pages[current_page_r]).instantiate()
	
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.add_child(new_left)
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.add_child(new_right)

func enter_toc():
	var left = $Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.get_child(1)
	var right = $Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.get_child(1)

	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer.remove_child(left)
	$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer.remove_child(right)

func _home():
	if current_page_l != 2:
		current_page_l = 1
		current_page_r = 2
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/LeftPageContainer/Page1.show()
		$Control/Background/MarginContainer/VBoxContainer/ManualVisuals/PageContent/RightPageContainer/Page2.show()
		enter_toc()
	

func _on_page_2_page_jump(leftp, rightp):
	print("Manual Script got the Signal.")
	current_page_l = leftp
	current_page_r = rightp
	update_page()
	#clear_signals()

#func clear_signals():
	#var node = $"."
	#var conns = node.get_signal_connection_list("page_jump")
	#for cur_conn in conns:
		#print(cur_conn)
		
		
