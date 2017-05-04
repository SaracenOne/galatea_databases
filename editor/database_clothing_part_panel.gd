tool
extends "database_panel.gd"

export(NodePath) var male_mesh = NodePath()
export(NodePath) var female_mesh = NodePath()
export(NodePath) var is_attachment = NodePath()

onready var _male_mesh_control = get_node(male_mesh)
onready var _female_mesh_control = get_node(female_mesh)
onready var _is_attachment_control = get_node(is_attachment)

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
	
	_is_attachment_control.set_disabled(false)
	_is_attachment_control.set_pressed(p_record.is_attachment)
	
func _on_MaleMeshControl_file_selected( p_path ):
	if(current_record):
		current_record.male_model_path = p_path
		current_database.mark_database_as_modified()
		
func _on_FemaleMeshControl_file_selected( p_path ):
	if(current_record):
		current_record.female_model_path = p_path
		current_database.mark_database_as_modified()

func _on_IsAttachmentCheckBox_toggled( pressed ):
	if(current_record):
		current_record.is_attachment = pressed
		current_database.mark_database_as_modified()
