extends Control
var selected = false
var offset: Vector2
signal move_to_top

var isConfiscated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$id_sprite/id_panel.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		$id_sprite/id_panel.global_position = get_global_mouse_position() - offset
		
	if(isConfiscated and self.position.y < self.position.y + (get_viewport_rect().size.y *3)/6):
		self.position.y += 500 * delta
		await get_tree().create_timer(1.5).timeout
		self.visible = false
		self.position.y = 1017
		isConfiscated = false

func _on_id_panel_button_pressed() -> void:
	if $id_sprite/id_panel.visible == true:
		$id_sprite/id_panel.visible = false


func _on_id_button_pressed() -> void:
	if $id_sprite/id_panel.visible == false:
		$id_sprite/id_panel.visible = true


func _on_id_panel_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		selected = true
		emit_signal('move_to_top', $".")
		offset = get_global_mouse_position() - $id_sprite/id_panel.global_position
	elif Input.is_action_just_released("left_click"):
		selected = false
		

func confiscateIdCard():
	$id_sprite/id_panel.visible = false
	isConfiscated = true

func setup_id(name,sprite,species_name,species_sym_path,id_expire_date, sector_name, sector_symbol,pattern_seq, stamp_path):
	$id_sprite/id_panel.set_name_label(name)
	$id_sprite/id_panel.set_pic(sprite)
	#Convert folder name to proper species name
	match species_name:
		"Amorphus":
			$id_sprite/id_panel.set_species("Amorphys")
		"Ancient":
			$id_sprite/id_panel.set_species("Ancient")
		"Foliage":
			$id_sprite/id_panel.set_species("Foliaceous")
		"Horned":
			$id_sprite/id_panel.set_species("Artiodactyl")
		"HumanOrgans":
			$id_sprite/id_panel.set_species("Offalis")
		"Marine":
			$id_sprite/id_panel.set_species("Marquatic")
		"Mechanical":
			$id_sprite/id_panel.set_species("Mechanica")
	$id_sprite/id_panel.set_spe_sym(species_sym_path)
	$id_sprite/id_panel.set_stamp(stamp_path)
	#Convert month from int to string representation 
	var month
	match id_expire_date[1]:
		1:	month = "January"
		2:	month = "February"
		3:	month = "March"
		4:	month = "April"	
		5:	month = "May"
		6:	month = "June"
		7:	month = "July"
		8:	month = "August"
		9:	month = "September"
		10:	month = "October"
		11:	month = "November"
		12:	month = "December"
	$id_sprite/id_panel.set_expiry(month + ". " + str(id_expire_date[0]) + ". " + str(id_expire_date[2]))
	$id_sprite/id_panel.set_starsec(sector_name)
	$id_sprite/id_panel.set_sector_symbol(sector_symbol)
	var temp_seq =""
	for shape in pattern_seq:
		temp_seq += shape
	$id_sprite/id_panel.set_pattern(temp_seq)
