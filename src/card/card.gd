extends Button

@onready var _is_flipped: bool = false
@onready var texture_icon: TextureRect = $icon


func _on_pressed():
	if _is_flipped: return
	if get_tree().root.get_node("root").flipped_cards.size() == 2: return
	_flip()  # Your function to show the icon

	# Tell the game manager (root node) that this card is flipped
	get_tree().root.get_node("root").card_flipped(self)


func _flip():
	_is_flipped = true
	
	# implement flipping texture logic here!
	texture_icon.texture = self.get_meta("icon_texture")


func flip_back():
	_is_flipped = false
	
	texture_icon.texture = preload("res://src/card/sprites/CardBack.png")


func set_matched():
	pass
