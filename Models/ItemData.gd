class_name ItemData

var id: int
var origin_texture
enum Slot {
	WEAPON,
	WINGS,
	CORE,
	ENGINE,
}
var slot = Slot.WEAPON

func _init(_id: int, _iconSrc: String):
   id = _id
   origin_texture = load(_iconSrc)
   # slot = _slot
