extends Control
tool

export(String) var label = "" setget set_label, get_label
export(String) var record_name = "" setget set_record_name, get_record_name

export(bool) var disabled = false setget set_disabled, get_disabled
export(bool) var has_clear_button = false setget set_has_clear_button, get_has_clear_button

signal record_selected(p_record)
signal record_erased(p_record)

var database = null
var record = null

var label_control = null
var record_reference_control = null

var database_list_popup = preload("database_list.tscn").instance()

func set_label(p_str):
	label = p_str
	if(label_control):
		label_control.set_text(label)
		
func get_label():
	return label
	
func set_record_name(p_str):
	record_name = p_str
	if(record_reference_control):
		record_reference_control.set_text(record_name)

func get_record_name():
	return record_name
	
func set_disabled(p_bool):
	disabled = p_bool
	var load_button = get_node("Container/LoadButton")
	if(load_button):
		load_button.set_disabled(p_bool)
		
	var clear_button = get_node("Container/ClearButton")
	if(clear_button):
		clear_button.set_disabled(p_bool)

func get_disabled():
	return disabled
	
func set_has_clear_button(p_bool):
	has_clear_button = p_bool
	var clear_button = get_node("Container/ClearButton")
	if(has_clear_button and clear_button):
		clear_button.show()
	else:
		clear_button.hide()

func get_has_clear_button():
	return has_clear_button

func _ready():
	label_control = get_node("RecordReferenceLabel")
	assert(label_control)
	label_control.set_text(label)
	
	record_reference_control = get_node("Container/RecordReferenceName")
	assert(record_reference_control)
	record_reference_control.set_text(record_name)
	
	if(has_clear_button):
		get_node("Container/ClearButton").show()
	else:
		get_node("Container/ClearButton").hide()
		
	add_child(database_list_popup)
	database_list_popup.connect("record_selected", self, "_on_record_selected")
	
func _on_LoadButton_pressed():
	if(database):
		database_list_popup.populate_tree(database)
		database_list_popup.popup_centered_ratio()

func _on_ClearButton_pressed():
	record_reference_control.set_text("")
	emit_signal("record_erased", record)
	
func _on_record_selected(p_record):
	record_reference_control.set_text(p_record.id)
	emit_signal("record_selected", p_record)
	
func assign_database(p_database):
	database = p_database