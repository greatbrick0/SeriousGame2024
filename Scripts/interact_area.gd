extends Area3D

@export var menuRef: PackedScene
var instanceRef: Node
@export_multiline var hoverText: String = ""

func Activate() -> void:
	if(menuRef == null): return
	instanceRef = menuRef.instantiate()
	HudManager.OpenNewMenu(instanceRef)
	HudManager.SetMouseLocked(false)
