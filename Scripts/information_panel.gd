extends Panel

func _on_button_pressed():
	HudManager.SetMouseLocked(true)
	queue_free()
