@tool
extends EditorPlugin

var button

func _enter_tree():
	button = Button.new()
	button.text = "Quick Open"
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button)

func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, button)
	button.queue_free()

func _on_button_pressed():
	var dialog := FileDialog.new()
	dialog.access = FileDialog.ACCESS_RESOURCES
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.connect("file_selected", Callable(self, "_on_file_selected"))
	get_editor_interface().get_base_control().add_child(dialog)
	dialog.popup_centered_ratio()

func _on_file_selected(path: String):
	get_editor_interface().open_scene_from_path(path)
