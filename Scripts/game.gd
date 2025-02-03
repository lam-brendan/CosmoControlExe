extends Node2D

@onready var alien_scene: PackedScene = preload("res://Scenes/alien.tscn")
# Called when the node enters the scene tree for the first time.

var alien_array: Array[Alien]

var message = []

var faxState
# Current index of the alien in the array
var curr_alien_i = 0

# Create an array of random aliens
func set_alien_array():
	alien_array.resize(2)
	for index in alien_array.size():
		var new_alien = alien_scene.instantiate()
		add_child(new_alien)
		new_alien.position = Vector2(0, get_viewport_rect().size.y / 2)
		alien_array[index] = new_alien

# Initialize game
func _ready():
	#$ShipSlot.texture = load("res://Art/BG/ship_slot_closed.png")
	set_alien_array()
	Global.incorrect_detain.clear()
	Global.incorrect_pass.clear()
	# Testing getters
	assert(alien_array[curr_alien_i].get_alien_sprite())
	
	for i in alien_array:
		#if !(i.get_alien_is_legal()):
		print(i.wrongInfo, i.get_id_card_expire_date(), i.get_visa_expire_date(), i.get_alien_name(), " ", i.get_visa_name(), " ", i.get_visa_boarding_date(), " ", i.get_purpose(), " ", i.get_alien_is_legal(), " ", i.get_document_sequence())
	
	var load_manual = load("res://Scenes/Manual/manual.tscn").instantiate()
	$ManualControl.add_child(load_manual)
	
	$ManualToggle/book.pressed.connect(_show_manual)
	
	$FaxControl/ShipFaxmachine.pressed.connect(showFax)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var alien_speed = get_viewport_rect().size.x / 10
	#update id card
	update_doc(alien_array[curr_alien_i].get_alien_name(), alien_array[curr_alien_i].get_id_card_image(),
	alien_array[curr_alien_i].get_species(), alien_array[curr_alien_i].get_species_symbol(),
	alien_array[curr_alien_i].get_id_card_expire_date(), alien_array[curr_alien_i].get_alien_star_sector(),
	alien_array[curr_alien_i].get_alien_star_sector_symbol(), alien_array[curr_alien_i].get_pattern_seq_converted(),
	 alien_array[curr_alien_i].get_purpose(), alien_array[curr_alien_i].get_visa_boarding_date(),
	 alien_array[curr_alien_i].get_visa_expire_date(), alien_array[curr_alien_i].get_stamp(),
	alien_array[curr_alien_i].get_alien_planet()
	)
	alien_array[curr_alien_i].position.y = alien_array[curr_alien_i].get_alien_height()
	
	# Once curr alien has passed through the door, call next alien
	if (alien_array[curr_alien_i].position.x >= get_viewport_rect().size.x + 550):
		print(alien_array[curr_alien_i].get_alien_name())
		print(alien_array[curr_alien_i].get_alien_star_sector())
		print(alien_array[curr_alien_i].get_alien_planet())
		print(alien_array[curr_alien_i].get_alien_star_sector_symbol())
		print(alien_array[curr_alien_i].get_alien_is_legal())
		if (alien_array[curr_alien_i].get_alien_is_legal() == false):
			print("Fined")
			var reason = grabReasonOfIllegalAlien(alien_array[curr_alien_i].wrongInfo)
			message.append("Illegal reason: " + reason)
			fax(true)
			Global.incorrect_pass.append(alien_array[curr_alien_i])
			
			
		if (curr_alien_i >= alien_array.size() - 1):
			get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
		else:
			curr_alien_i += 1
		
	# When the door is locked
	if ($DoorLock.is_door_locked):
		
		# If alien.pos < midway point, keep going until midway, then stop
		if (alien_array[curr_alien_i].position.x < get_viewport_rect().size.x / 2 + 349):
			print(alien_array[curr_alien_i].position.x)
			alien_array[curr_alien_i].position.x += 300 * delta
			if (alien_array[curr_alien_i].position.x > (get_viewport_rect().size.x / 2) + 345 && alien_array[curr_alien_i].position.x < (get_viewport_rect().size.x / 2) + 355):
				$documents/alien_document.position.y = 992
				$ShipSlot.set_texture(load("res://Art/BG/ship_slot_open.png"))
				await get_tree().create_timer(0.25).timeout
				$documents/id_card.visible = true
				await get_tree().create_timer(0.2).timeout
				$documents/alien_document.visible = true
				await get_tree().create_timer(0.5).timeout
				$ShipSlot.set_texture(load("res://Art/BG/ship_slot_closed.png"))
			
		# If alien.pos > midway point, continue through door
		if (alien_array[curr_alien_i].position.x > get_viewport_rect().size.x / 2 + 351):
			alien_array[curr_alien_i].position.x += 300 * delta
	
	# When the door is unlocked, aliens continue to pass through door
	else:
		
		if ($documents/id_card.visible == true):
			#need to fix this when you 
			set_process(false)
			$ShipSlot.set_texture(load("res://Art/BG/ship_slot_open.png"))
			await get_tree().create_timer(0.25).timeout
			$documents/id_card/id_sprite/id_panel.visible = false
			$documents/id_card.visible = false
			await get_tree().create_timer(0.2).timeout
			$documents/alien_document/doc_sprite/alien_doc_panel.visible = false
			$documents/alien_document.visible = false
			await get_tree().create_timer(0.5).timeout
			$ShipSlot.set_texture(load("res://Art/BG/ship_slot_closed.png"))
			await get_tree().create_timer(0.25).timeout
			set_process(true)
		
		alien_array[curr_alien_i].position.x += alien_speed * delta
		
		
#Show the manual when button is clicked
func _show_manual():
	print("Showing Manual")
	var temp = $ManualControl.get_child(0)
	temp.get_node("Control").visible = true

#The main detain function and character reset
func detain():
	print("Detain in progress")
	
	var deathSoundFile = ""
	
	var randomDeathSoundFileNum = randi_range(1, 4)
	
	match randomDeathSoundFileNum:
		1:
			deathSoundFile = "res://Audio/Jello Death.mp3"
		2:
			deathSoundFile = "res://Audio/Thaid Partied Death.mp3"
		3:
			deathSoundFile = "res://Audio/Whale Death 2.mp3"
		4:
			deathSoundFile = "res://Audio/Whale Death.mp3"
			
	$DetainSoundEffect.stream = load(deathSoundFile)
	
	$Lights.energy = 0.7
	$DetainSoundEffect.play()
	await get_tree().create_timer(1.5).timeout
	$DetainSoundEffect.stop()
	$Lights.energy = 0
	
	if (alien_array[curr_alien_i].get_alien_is_legal() == true):
		print("bad detain")
		
		message.append("Detained a legal alien")
		fax(true)
		
		Global.incorrect_detain.append(alien_array[curr_alien_i])
	
	$documents/alien_document.confiscateAlienDocuments()
	$documents/id_card.confiscateIdCard()
	
	alien_array[curr_alien_i].position.x = -350
	set_process(false)
	await get_tree().create_timer(4).timeout
	$DoorLock/unlock_button.texture_disabled = load("res://Art/Utilities/ship_lockOpenActive.png")
	$DoorLock/unlock_button.disabled = false
	set_process(true)
	
	if (curr_alien_i >= alien_array.size() - 1):
			get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
	else:
		curr_alien_i += 1

func fax(state):
	print(state)
	faxState = state
	
	#var fineDetails = alien_array[curr_alien_i].wrongInfo
	#var legalState = alien_array[curr_alien_i].get_alien_is_legal()
	#var name = alien_array[curr_alien_i].get_alien_name()
	
	#var message = []
	#print(message)
	$FaxControl/ShipFaxmachine.disabled = !faxState
	
	#if (legalState == true):
		#message.append("Detained a legal alien")
	#elif(legalState == false):
		#var reason = grabReasonOfIllegalAlien(fineDetails)
		#message.append("Illegal reason: " + reason)
	
	print(message)
	
	while (faxState):
		#print(faxState, " state ", fineDetails, " ",legalState, " ", name)
		$FaxControl/ShipFaxmachine.modulate = Color.YELLOW
		await get_tree().create_timer(0.2).timeout
		$FaxControl/ShipFaxmachine.modulate = Color.WHITE
		await get_tree().create_timer(0.2).timeout
	
	showFax(message)

func update_doc(alien_name, id_sprite, species, species_sym_path, id_expire_date, sector_name, sector_symbol,
 pattern_seq, purpose, boarding_date, visa_expiry_date, stamp_path, planet):
	#update id card
	$documents/id_card.setup_id(alien_name, id_sprite, species, species_sym_path, id_expire_date,
	sector_name, sector_symbol, pattern_seq, stamp_path)
	
	#update visa card
	$documents/alien_document.setup_visa(alien_name, species, species_sym_path, sector_name, sector_symbol,
	purpose, boarding_date, visa_expiry_date, stamp_path, planet)


func _on_ship_faxmachine_pressed():
	fax(false)
	print("Fax Clicked")
	

func grabReasonOfIllegalAlien(wrongInfo):
	match wrongInfo:
		1:
			return "Id Card Expired"
		2:
			return "Visa Expired"
		3:
			return "Mismatch Visa Name"
		4:
			return "Boarding Date is incorrect"
		5:
			return "Incorrect Symbol Sequence"
		6:
			return "Illegal Purpose of Visit"
		7:
			return "Illegal Alien Variant"
		8:
			return "Image of Alien on ID Card does not match Alien"
		9:
			return "Illegal Star Sector or Planet Combo"
		10:
			return "Incorrect Star Sector Symbol"
		11:
			return "Incorrect Stamp Symbol"
		12:
			return "Mismatch Species Symbol"

#Show the fax message
func showFax(Message):
	print("Showing Fax Message ", Message)
	
	var finalMessage = ""
	var counter = 1
	
	for i in Message:
		#if (finalMessage == null):
			#finalMessage = i
		#else:
		finalMessage = finalMessage + '\n' + str(counter) + ": " + i
		counter += 1
	
	print("Final Message ", finalMessage)
	$FaxControl/ShipFaxmachine/FaxMessage/FaxPaper/Text.text = finalMessage
	await get_tree().create_timer(0.2).timeout
	$FaxControl/ShipFaxmachine/FaxMessage.visible = true


func _on_exit_fax_message_button_pressed():
	$FaxControl/ShipFaxmachine/FaxMessage.visible = false
	$FaxControl/ShipFaxmachine/FaxMessage/FaxPaper/Text.text = ""
	message = []
