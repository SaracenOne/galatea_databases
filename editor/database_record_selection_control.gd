extends Control
tool

signal record_selected(p_record)

export(String) var label = "" setget set_label, get_label
export(String) var record_name = "" setget set_record_name, get_record_name

export(bool) var disabled = false setget set_disabled, get_disabled

var database = null

var label_control = null
var record_selection_path_control = null

var database_list_popup = preload("database_list.tscn").instance()

func set_label(p_str):
	label = p_str
	if(label_control):
		label_control.set_text(label)
		
func get_label():
	return label
	
func set_record_name(p_str):
	record_name = p_str
	if(record_selection_path_control):
		record_selection_path_control.set_text(record_name)

func get_record_name():
	return record_name
	
func set_disabled(p_bool):
	disabled = p_bool
	var button = get_node("Container/LoadButton")
	if(button):
		button.set_disabled(p_bool)

func get_disabled():
	return disabled
	
func assign_database(p_database):
	database = p_database

func _ready():
	label_control = get_node("RecordSelectionLabel")
	assert(label_control)
	label_control.set_text(label)
	
	record_selection_path_control = get_node("Container/RecordSelectionPath")
	assert(record_selection_path_control)
	record_selection_path_control.set_text(record_name)
	
	add_child(database_list_popup)

	database_list_popup.connect("record_selected", self, "_on_record_selected")
	
func _on_record_selected(p_record):
	set_record_name(p_record.id)
	
	emit_signal("record_selected", p_record)
	
func _on_LoadButton_pressed():
	if(database):
		database_list_popup.populate_tree(database)
		database_list_popup.popup_centered_ratio()