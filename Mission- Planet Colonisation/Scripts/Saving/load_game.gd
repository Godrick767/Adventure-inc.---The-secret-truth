extends Button

@export var file_num := 1

var Return

func _on_button_down() -> void:
	if not FileAccess.file_exists("user://save_" + str(file_num) + ".json"):
		Return = null
		push_error("File not found, pls contact the dev on: gorick.yt.2@gmail.com")
		return
	
	var file := FileAccess.open("user://save_" + str(file_num) + ".json", FileAccess.READ)
	
	var content = file.get_as_text()
	file.close()
	
	if content.strip_edges() == "":
		get_tree().change_scene_to_packed(load("res://Scenes/World 1/RUINS/W1-RUINS-5-1-0-0-N.tscn"))
	
	SaveLoad.load_game("user://save_" + str(file_num) + ".json")
	return
