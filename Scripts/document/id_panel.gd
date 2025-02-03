extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_name_label (name):
	$id_panel/name.text = name.to_upper()
	
func set_pic (pic_path):
	$id_panel/pic.texture = load(pic_path)

func set_species(species):
	$id_panel/spe/species.text = species.to_upper()

func set_spe_sym(species_path):
	$id_panel/spe_symbol.texture = load(species_path)
	
func set_expiry (exp):
	$id_panel/exp/expiry.text = exp.to_upper()
	
func set_starsec (sector_name):
	$id_panel/star_sec/sec.text = sector_name.to_upper()
	
func set_sector_symbol (sector_symbol):
	$id_panel/sec_symbol.texture = load(sector_symbol)
	
func set_pattern (pattern):
	$id_panel/pattern.text = pattern

func set_stamp (stamp_path):
	$id_panel/stamp.texture = load(stamp_path)
