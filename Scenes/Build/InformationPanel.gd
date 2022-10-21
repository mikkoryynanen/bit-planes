extends HBoxContainer

onready var information_label: RichTextLabel = $InformationLabel
onready var attach_button: Button = $ButtonsContainer/Attach
onready var unattach_button: Button = $ButtonsContainer/Unattach
onready var purchase_button: Button = $ButtonsContainer/Purchase


func _ready():
	information_label.bbcode_text = ""


func show_attahed_item_content():
	attach_button.visible = false
	unattach_button.visible = true
	purchase_button.visible = false


func show_unattached_item_content():
	attach_button.visible = true
	unattach_button.visible = false
	purchase_button.visible = false


func show_purchaseable_item_content():
	attach_button.visible = false
	unattach_button.visible = false
	purchase_button.visible = true


func set_text(text: String):
	information_label.bbcode_text = text
