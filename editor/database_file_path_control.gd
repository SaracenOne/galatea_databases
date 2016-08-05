extends Control
tool

signal file_selected(p_path)

export(String) var label = "" setget set_label, get_label
export(String) var file_path = "" setget set_file_path, get_file_path
export(String) var file_browser_title = "" setget set_file_browser_title, get_file_browser_title

export(String) var file_type = "" setget set_file_type, get_file_type

export(bool) var disabled = false setget set_disabled
export(bool) var has_clear_button = false setget set_has_clear_button, get_has_clear_button

var label_control = null
var file_path_control = null

var editor_file_dialog = FileDialog.new()

func set_label(p_str):
	if(p_str):
		label = p_str
	else:
		label = ""
	if(label_control):
		label_control.set_text(label)
		
func get_label():
	return label
	
func set_file_path(p_str):
	file_path = p_str
	if(file_path_control):
		file_path_control.set_text(file_path)

func get_file_path():
	return file_path
	
func set_file_browser_title(p_str):
	if(p_str):
		file_browser_title = p_str
	else:
		file_browser_title = ""
	if(editor_file_dialog):
		editor_file_dialog.set_title(file_browser_title)

func get_file_browser_title():
	return file_browser_title
	
func set_file_type(p_file_type):
	file_type = p_file_type
	editor_file_dialog.clear_filters();
	if(file_type):
		var file_extensions = ResourceLoader.get_recognized_extensions_for_type(file_type)
		for extension in file_extensions:
			editor_file_dialog.add_filter("*." + extension + " ; " + extension.to_upper())

func get_file_type():
	return file_type
	
func set_disabled(p_bool):
	disabled = p_bool
	
	if(has_node("Container/LoadButton")):
		var load_button = get_node("Container/LoadButton")
		if(load_button):
			load_button.set_disabled(p_bool)
	if(has_node("Container/ClearButton")):
		var clear_button = get_node("Container/ClearButton")
		if(clear_button):
			clear_button.set_disabled(p_bool)
	
func set_has_clear_button(p_bool):
	has_clear_button = p_bool
	if(has_node("Container/ClearButton")):
		var button = get_node("Container/ClearButton")
		if(button):
			if(has_clear_button):
				button.show()
			else:
				button.hide()

func get_has_clear_button():
	return has_clear_button

func _ready():
	label_control = get_node("FileLabel")
	assert(label_control)
	label_control.set_text(label)
	
	file_path_control = get_node("Container/FilePath")
	assert(file_path_control)
	file_path_control.set_text(file_path)
	
	if(has_clear_button):
		get_node("Container/ClearButton").show()
	else:
		get_node("Container/ClearButton").hide()
	
	add_child(editor_file_dialog)
	
	editor_file_dialog.set_title(file_browser_title);
	editor_file_dialog.connect("file_selected", self, "_on_file_selected")
	editor_file_dialog.set_mode(FileDialog.MODE_OPEN_FILE);
	editor_file_dialog.set_access(FileDialog.ACCESS_RESOURCES);
	editor_file_dialog.set_current_path("res://")
	
func _on_file_selected(p_path):
	set_file_path(p_path)
	
	emit_signal("file_selected", p_path)
	
func _on_LoadButton_pressed():
	editor_file_dialog.popup_centered_ratio()

func _on_ClearButton_pressed():
	set_file_path("")
	
	emit_signal("file_selected", "")