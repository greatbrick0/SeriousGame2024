extends ColorRect

func _on_resume_button_pressed():
	HudManager.SetMouseLocked(true)
	queue_free()

func _on_quit_button_pressed():
	get_tree().quit()
