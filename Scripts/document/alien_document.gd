extends Control
var selected = false
var offset: Vector2
signal move_to_top

var isConfiscated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$doc_sprite/alien_doc_panel.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		$doc_sprite/alien_doc_panel.global_position = get_global_mouse_position() - offset
	
	if(isConfiscated and self.position.y <  self.position.y +(get_viewport_rect().size.y *3)/6):
		self.position.y += 500 * delta
		await get_tree().create_timer(1.5).timeout
		self.visible = false
		self.position.y = -34
		isConfiscated = false


func _on_sprite_button_pressed() -> void:
	if $doc_sprite/alien_doc_panel.visible == false:
			$doc_sprite/alien_doc_panel.visible = true


func _on_doc_panel_button_pressed() -> void:
	if $doc_sprite/alien_doc_panel.visible == true:
			$doc_sprite/alien_doc_panel.visible = false


func _on_alien_doc_panel_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		selected = true
		emit_signal('move_to_top', $".")
		offset = get_global_mouse_position() - $doc_sprite/alien_doc_panel.global_position
	elif Input.is_action_just_released("left_click"):
		selected = false
		
func confiscateAlienDocuments():
	$doc_sprite/alien_doc_panel.visible = false
	isConfiscated = true
	
func setup_visa(alien_name, species_name, species_sym_path, sector_name, sector_symbol, purpose, 
boarding_date, visa_expiry_date, stamp_path,planet) -> void:
	$doc_sprite/alien_doc_panel.set_name_label(alien_name)
		#Convert folder name to proper species name
	match species_name:
		"Amorphus":
			$doc_sprite/alien_doc_panel.set_species("Amorphys")
			$doc_sprite/alien_doc_panel.set_description("These structureless organism lack a proper skeletal structure have ooze like outer texture. They able to morph into different shapes and structures to help fit through small spaces.")
		"Ancient":
			$doc_sprite/alien_doc_panel.set_species("Ancient")
			$doc_sprite/alien_doc_panel.set_description("These creatures are  speculated to be a forefather species mentioned in ancient alien historical texts and mythology. They are relatively large in form and physically varies from one another but all display an solemn air.")
		"Foliage":
			$doc_sprite/alien_doc_panel.set_species("Foliaceous")
			$doc_sprite/alien_doc_panel.set_description("A ferocious species that foster plant like characteristics such as flowers, fines, leaves, etc. These species have adapted to sustain themselves on sunlight and meagre nourishment from unexpecting prey. ") 
		"Horned":
			$doc_sprite/alien_doc_panel.set_species("Artiodactyl")
			$doc_sprite/alien_doc_panel.set_description("Due to their home planet's harsh rocky landscape, they’ve evolved their horns to help to traverse the environment and are used in combat. The size of an Artiodactyls horn is tied their age.")
		"HumanOrgans":
			$doc_sprite/alien_doc_panel.set_species("Offalis")
			$doc_sprite/alien_doc_panel.set_description("The unique flesh ecosystem of their home planets, has resulted in unnerving or boorish tissue adaptations in these creatures. There’s a wide variation in how much flesh of their flesh is exposed.")
		"Marine":
			$doc_sprite/alien_doc_panel.set_species("Marquatic")
			$doc_sprite/alien_doc_panel.set_description("Aquatic life forms that has evolved to breathe out of water to allow them to travel through land. Prolonged absence from water causes their bodies to shrivel up and and reduce in size. ")
		"Mechanical":
			$doc_sprite/alien_doc_panel.set_species("Mechanica")
			$doc_sprite/alien_doc_panel.set_description("Non-organic species that reproduces by constructing their new members. They have a metallic appearance and possess body structures crafted out of alloy originating from their home planet that imbues sentience")

	$doc_sprite/alien_doc_panel.set_spe_sym(species_sym_path)
	$doc_sprite/alien_doc_panel.set_starsec(sector_name,planet)
	$doc_sprite/alien_doc_panel.set_sector_symbol(sector_symbol)
	
	$doc_sprite/alien_doc_panel.set_purpose(purpose)

	$doc_sprite/alien_doc_panel.set_boarding(convert_month(boarding_date[1]) + ". " + str(boarding_date[0]) + ". " + str(boarding_date[2]))
	$doc_sprite/alien_doc_panel.set_expiry(convert_month(visa_expiry_date[1]) + ". " + str(visa_expiry_date[0]) + ". " + str(visa_expiry_date[2]))
	$doc_sprite/alien_doc_panel.set_stamp(stamp_path)

func convert_month(month) -> String:
	match month:
		1:	return "January"
		2:	return "February"
		3:	return "March"
		4:	return "April"	
		5:	return "May"
		6:	return "June"
		7:	return "July"
		8:	return "August"
		9:	return "September"
		10:	return "October"
		11:	return "November"
		12:	return "December"
	return ""
