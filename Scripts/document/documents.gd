extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for panel in get_children():
		panel.move_to_top.connect(move_doc_to_top)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_doc_to_top(node):
	print(node.get_name(), " ", node.get_index())
	move_child(node, (get_child_count()-1))
