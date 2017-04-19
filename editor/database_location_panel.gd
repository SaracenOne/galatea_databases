tool
extends "database_panel.gd"

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var scene_file_control = NodePath()
export(NodePath) var skybox_file_control = NodePath()
export(NodePath) var is_interior_control = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _scene_file_control_node = get_node(scene_file_control)
onready var _skybox_file_control_node = get_node(skybox_file_control)
onready var _is_interior_control_node = get_node(is_interior_control)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.location_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("location_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_scene_file_control_node.set_file_path(current_record.scene_path)
	_scene_file_control_node.set_disabled(false)
	
	_skybox_file_control_node.set_file_path(current_record.skybox_path)
	_skybox_file_control_node.set_disabled(false)

func _on_printed_name_text_changed(p_printed_name):
	if(current_record):
		current_record.printed_name = p_printed_name
		current_database.mark_database_as_modified()

func _on_scene_file_selected(p_path):
	if(current_record):
		current_record.scene_path = p_path
		current_database.mark_database_as_modified()
		
func _on_skybox_file_selected(p_path):
	if(current_record):
		current_record.skybox_path = p_path
		current_database.mark_database_as_modified()
		

func _on_IsInteriorCheckbox_toggled( pressed ):
	if(current_record):
		current_record.is_interior = pressed
		current_database.mark_database_as_modified()
