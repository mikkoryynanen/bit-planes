extends TextureRect

export(int) var slot_id = 0

var itemData


func set_data(data):
	itemData = data
	if data: 
		self.texture = load(data.iconSrc)
		# self.texture.expand = true
		# self.texture.rect_size = Vector2(16, 16)

func get_drag_data(position):
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = self.texture
	drag_texture.rect_size = Vector2(16, 16)

	var control = Control.new()
	control.add_child(drag_texture)
	set_drag_preview(control)

	return itemData

func can_drop_data(position, data) -> bool:
	return GameData.can_attach_item(slot_id)

func drop_data(position, data):
	texture = load(data.iconSrc)
	Events.emit_signal("on_item_attached", data, slot_id)
