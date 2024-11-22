extends Node

var mouseLocked: bool = true
var hoverText: String = ""
var playerRef: Node3D

func _process(delta):
	if(Input.is_action_just_pressed("Quit")):
		SetMouseLocked(false)
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED if mouseLocked else Input.MOUSE_MODE_VISIBLE
	$WalkingHud.visible = mouseLocked
	$MenuHud.visible = !mouseLocked
	$WalkingHud/HoverTextPanel.visible = hoverText != ""
	$WalkingHud/HoverTextPanel/Label.text = hoverText

func SetMouseLocked(newMouseLocked: bool) -> void:
	mouseLocked = newMouseLocked
	playerRef.mouseLocked = newMouseLocked

func OpenNewMenu(newMenu: Node) -> void:
	$MenuHud.add_child(newMenu)
