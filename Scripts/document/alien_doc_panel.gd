extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_name_label (name):
	$doc_info_panel/name.text = name.to_upper()
	
func set_species(species):
	$doc_info_panel/species.text = species.to_upper()

func set_spe_sym(species_sym_path):
	$doc_info_panel/species_sym.texture = load(species_sym_path)

#set sector and planet in one line	
func set_starsec (sector_name, planet):
	$doc_info_panel/star_sec.text = (sector_name.to_upper() + " - " + planet)
	
func set_sector_symbol (sector_symbol):
	$doc_info_panel/sec_sym.texture = load(sector_symbol)
	
func set_description(description):
	$doc_info_panel/description.text = description

func set_boarding (boarding_exp):
	$doc_info_panel/boarding.text = boarding_exp.to_upper()

func set_purpose (purpose):
	$doc_info_panel/purpose.label_settings = LabelSettings.new()
	if (purpose.length() > 20):
		$doc_info_panel/purpose.label_settings.font_size = 14
	elif(purpose.length() > 12) :
		$doc_info_panel/purpose.label_settings.font_size = 20
	else:
		$doc_info_panel/purpose.label_settings.font_size = 24	
	$doc_info_panel/purpose.text = purpose.to_upper()
	
func set_expiry (exp):
	$doc_info_panel/expiry.text = exp.to_upper()
		
func set_stamp (stamp_path):
	$doc_info_panel/stamp.texture = load(stamp_path)
