extends HBoxContainer

onready var information_label: RichTextLabel = $InformationLabel
onready var attach_button: Button = $ButtonsContainer/Attach
onready var unattach_button: Button = $ButtonsContainer/Unattach


func _ready():
	information_label.bbcode_text = ""


func show_attahed_item_content():
	attach_button.visible = false
	unattach_button.visible = true


func show_unattached_item_content():
	attach_button.visible = true
	unattach_button.visible = false


func set_text(text: String):
	information_label.bbcode_text = text
