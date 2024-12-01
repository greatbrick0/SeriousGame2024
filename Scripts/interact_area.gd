extends Area3D

@export var menuRef: PackedScene
var instanceRef: Node
@export_multiline var hoverText: String = ""

signal activated(ref)

func Activate() -> void:
	if(menuRef == null): return
	instanceRef = menuRef.instantiate()
	HudManager.OpenNewMenu(instanceRef)
	HudManager.SetMouseLocked(false)
	emit_signal("activated", instanceRef)
