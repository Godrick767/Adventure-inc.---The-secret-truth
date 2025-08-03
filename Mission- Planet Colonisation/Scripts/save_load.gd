class_name SaverLoader 
extends Node2D

func save_game():
	var file := FileAccess.open("user://save_1.json", FileAccess.WRITE)
	
	var saved_data = {}
	
	saved_data["player_gp_x"] = player.global_position.x
	saved_data["player_gp_y"] = player.global_position.y
	saved_data["player_max_hp"] = player.max_hp
	saved_data["player_hp"] = player.hp
	saved_data["player_TB"] = player.TB
	saved_data["player_max_TB"] = player.max_TB
	saved_data["player_max_jumps"] = player.max_jumps
	saved_data["player_jumps"] = player.jumps
	saved_data["player_atk"] = player.dmg
	saved_data["player_scene"] = get_tree().current_scene.scene_file_path
	
	var json = JSON.stringify(saved_data)
	
	file.store_string(json)
	file.close()

func load_game(path: String):
	var file := FileAccess.open(path, FileAccess.READ)
	
	var json = file.get_as_text()
	
	var saved_data = JSON.parse_string(json)
	
	#I don't fucking care what this is but it's necessary for the player to be happy, but it makes my life hell. But still don't remove the players liking of the game is more important then my life *Sob* Comedy...
	player.global_position.x = saved_data["player_gp_x"]
	player.global_position.y = saved_data["player_gp_y"]
	
	#TB and HP shit
	player.max_hp = saved_data["player_max_hp"]
	player.hp = saved_data["player_hp"]
	player.TB = saved_data["player_TB"]
	player.max_TB = saved_data["player_max_TB"]
	
	#Jump shit
	player.max_jumps = saved_data["player_max_jumps"]
	
	#Dmg shit
	player.dmg = saved_data["dmg"]
	
	#Scene Shit
	get_tree().change_scene_to_packed(saved_data["scene"])
