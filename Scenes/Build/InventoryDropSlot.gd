extends GridContainer



func can_drop_data(position, data) -> bool:
	# Currently we do not have inventory max value
	return true

func drop_data(position, data):
	# Move the dropped item from ship back to inventory
	Events.emit_signal("on_item_inventory", data)
