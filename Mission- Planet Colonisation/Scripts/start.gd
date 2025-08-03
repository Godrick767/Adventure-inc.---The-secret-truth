extends Button

func _on_button_down() -> void:
	get_tree().change_scene_to_packed(load("res://Scenes/save_choose.tscn"))
