extends Control

@onready var grid = $GridContainer
@export var card_scene: PackedScene

var flipped_cards: Array = []


func _ready():
	var icons = _preload_icons()
	var shuffled_icons = icons.duplicate()
	shuffled_icons.append_array(icons) # duplicate to make pairs
	shuffled_icons.shuffle()

	for i in range(16):
		var card = card_scene.instantiate()
		grid.add_child(card)
		card.set_meta("icon_texture", shuffled_icons[i])
		card.set_meta("card_type", _get_base_name(shuffled_icons[i]))
		card.get_node("icon").texture = preload("res://src/card/sprites/CardBack.png") #face-down


func _preload_icons() -> Array:
	return [
		preload("res://src/card/sprites/BlueHeart.png"),
		preload("res://src/card/sprites/BluePotion.png"),
		preload("res://src/card/sprites/Emoji.png"),
		preload("res://src/card/sprites/GreenHeart.png"),
		preload("res://src/card/sprites/GreenPotion.png"),
		preload("res://src/card/sprites/Heart.png"),
		preload("res://src/card/sprites/Potion.png"),
		preload("res://src/card/sprites/Sword.png"),
	]


func card_flipped(card) -> void:
	flipped_cards.append(card)

	if flipped_cards.size() == 2:
		var first = flipped_cards[0]
		var second = flipped_cards[1]
		
		var first_type = first.get_meta("card_type")
		var second_type = second.get_meta("card_type")

		if first_type != second_type:
			# No match: flip back after delay
			await get_tree().create_timer(1.0).timeout
			first.flip_back()
			second.flip_back()

		flipped_cards.clear()


func _get_base_name(texture: Resource) -> String:
		# 1. Get the full resource path as a string
	var path := texture.resource_path  # Example: "res://src/card/sprites/BlueHeart.png"

	# 2. Use get_file() to get the filename: "BlueHeart.png"
	var file_name := path.get_file()

	# 3. Remove the extension to get just "BlueHeart"
	var base_name := file_name.get_basename()
	return base_name
