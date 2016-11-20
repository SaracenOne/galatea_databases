tool
extends "database_panel.gd"
#
var database_records = null

export(NodePath) var male_mesh = NodePath()
export(NodePath) var female_mesh = NodePath()

onready var _male_mesh_control = get_node(male_mesh)
onready var _female_mesh_control = get_node(female_mesh)

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

	current_database = galatea_databases.clothing_part_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("clothing_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_male_mesh_control.set_disabled(false)
	_male_mesh_control.set_file_path(p_record.male_model_path)
	
	_female_mesh_control.set_disabled(false)
	_female_mesh_control.set_file_path(p_record.female_model_path)
	
func _on_MaleMeshControl_file_selected( p_path ):
	if(current_record):
		current_record.male_model_path = p_path
		current_database.mark_database_as_modified()
		
func _on_FemaleMeshControl_file_selected( p_path ):
	if(current_record):
		current_record.female_model_path = p_path
		current_database.mark_database_as_modified()