tool
extends "database_panel.gd"

#
var database_records = null

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var scene_file_control = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _scene_file_control_node = get_node(scene_file_control)

func _ready():
	pass

func galatea_databases_assigned():
	database_records = get_node("LeftSide/DatabaseRecords")
	assert(database_records)

	if not(is_connected("new_record_duplicate", database_records, "new_record_duplicate_callback")):
		connect("new_record_duplicate", database_records, "new_record_duplicate_callback")

	if not(is_connected("new_record_add_successful", database_records, "new_record_add_successful_callback")):
		connect("new_record_add_successful", database_records, "new_record_add_successful_callback")

	if not(is_connected("rename_record_successful", database_records, "rename_record_successful_callback")):
		connect("rename_record_successful", database_records, "rename_record_successful_callback")

	if not(is_connected("erase_record_successful", database_records, "erase_record_successful_callback")):
		connect("erase_record_successful", database_records, "erase_record_successful_callback")

	current_database = galatea_databases.hair_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("hair_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)

	_scene_file_control_node.set_file_path(current_record.scene_path)
	_scene_file_control_node.set_disabled(false)

func _on_printed_name_text_changed(p_printed_name):
	if(current_record):
		current_record.printed_name = p_printed_name
		current_database.mark_database_as_modified()

func _on_scene_file_selected(p_path):
	if(current_record):
		current_record.scene_path = p_path
		current_database.mark_database_as_modified()
