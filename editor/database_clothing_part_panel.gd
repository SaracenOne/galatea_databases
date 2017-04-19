tool
extends "database_panel.gd"

export(NodePath) var male_mesh = NodePath()
export(NodePath) var female_mesh = NodePath()

onready var _male_mesh_control = get_node(male_mesh)
onready var _female_mesh_control = get_node(female_mesh)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
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