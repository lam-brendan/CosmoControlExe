extends Control

signal page_jump(left,right)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/GridContainer/ButtonOperation.pressed.connect(jump_page_emit.bind(3,4))
	$MarginContainer/VBoxContainer/GridContainer/ButtonWorkstation.pressed.connect(jump_page_emit.bind(3,4))
	$MarginContainer/VBoxContainer/GridContainer/ButtonStarsector.pressed.connect(jump_page_emit.bind(13,14))
	$MarginContainer/VBoxContainer/GridContainer/ButtonSpecies.pressed.connect(jump_page_emit.bind(19,20))
	$MarginContainer/VBoxContainer/GridContainer/ButtonMarquatics.pressed.connect(jump_page_emit.bind(21,22))
	$MarginContainer/VBoxContainer/GridContainer/ButtonOffalis.pressed.connect(jump_page_emit.bind(23,24))
	$MarginContainer/VBoxContainer/GridContainer/ButtonAmorphia.pressed.connect(jump_page_emit.bind(25,26))
	$MarginContainer/VBoxContainer/GridContainer/ButtonAncient.pressed.connect(jump_page_emit.bind(27,28))
	$MarginContainer/VBoxContainer/GridContainer/ButtonArtiodactyl.pressed.connect(jump_page_emit.bind(29,30))
	$MarginContainer/VBoxContainer/GridContainer/ButtonFoliaceous.pressed.connect(jump_page_emit.bind(31,32))
	$MarginContainer/VBoxContainer/GridContainer/ButtonMechanica.pressed.connect(jump_page_emit.bind(33,34))
	$MarginContainer/VBoxContainer/GridContainer/ButtonDocuments.pressed.connect(jump_page_emit.bind(35,36))
	$MarginContainer/VBoxContainer/GridContainer/ButtonsFields.pressed.connect(jump_page_emit.bind(37,38))
	$MarginContainer/VBoxContainer/GridContainer/ButtonStamps.pressed.connect(jump_page_emit.bind(39,40))
	$MarginContainer/VBoxContainer/GridContainer/ButtonSequence.pressed.connect(jump_page_emit.bind(41,42))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func jump_page_emit(rightp,leftp):
	print("signal emitted")
	emit_signal("page_jump",rightp,leftp)
	
