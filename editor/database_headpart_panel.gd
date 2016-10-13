tool
extends "database_panel.gd"

const headpart_record_const = preload("../databases/headpart_record.gd")
#
var database_records = null

export(NodePath) var headpart_type_control = NodePath()
export(NodePath) var mesh_file_control = NodePath()
export(NodePath) var texture_file_control = NodePath()
export(NodePath) var texture_file_preview_control = NodePath()
export(NodePath) var gen_morph_file_control = NodePath()

export(NodePath) var target_min_x_control = NodePath()
export(NodePath) var target_min_y_control = NodePath()

export(NodePath) var target_max_x_control = NodePath()
export(NodePath) var target_max_y_control = NodePath()

onready var _headpart_type_control_node = get_node(headpart_type_control)
onready var _mesh_file_control_node = get_node(mesh_file_control)
onready var _texture_file_control_node = get_node(texture_file_control)
onready var _texture_file_preview_control_node = get_node(texture_file_preview_control)
onready var _gen_morph_file_control_node = get_node(gen_morph_file_control)

onready var _target_min_x_control_node = get_node(target_min_x_control)
onready var _target_min_y_control_node = get_node(target_min_y_control)
onready var _target_max_x_control_node = get_node(target_max_x_control)
onready var _target_max_y_control_node = get_node(target_max_y_control)

func _ready():
	pass

func update_main_texture_preview(record):
	_texture_file_preview_control_node.set_texture(null)
	var main_texture = null
	if(!record.texture_path.empty()):
		main_texture = load(record.texture_path)
	if(main_texture):
		if(main_texture extends Texture):
			_texture_file_preview_control_node.set_texture(main_texture)

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

	current_database = galatea_databases.headpart_database
	
	var headpart_type_popup = _headpart_type_control_node.get_popup()
	for i in range(0, headpart_record_const.HEADPART_MAX):
		headpart_type_popup.add_item(headpart_record_const.get_string_from_headpart(i), i) 
	if(!headpart_type_popup.is_connected("item_pressed", self, "_on_headpart_type_selected")):
		headpart_type_popup.connect("item_pressed", self, "_on_headpart_type_selected")
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("location_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_headpart_type_control_node.set_text(headpart_record_const.get_string_from_headpart(p_record.headpart_type))
	_headpart_type_control_node.set_disabled(false)

	_mesh_file_control_node.set_file_path(p_record.mesh_path)
	_mesh_file_control_node.set_disabled(false)
	
	_texture_file_control_node.set_file_path(p_record.texture_path)
	_texture_file_control_node.set_disabled(false)
	
	update_main_texture_preview(p_record)
	
	_gen_morph_file_control_node.set_file_path(p_record.gen_morph_path)
	_gen_morph_file_control_node.set_disabled(false)
	
	###
	_target_min_x_control_node.set_step(0.0000001)
	_target_min_x_control_node.set_editable(true)
	_target_min_x_control_node.set_value(p_record.target_min.x)
	
	_target_min_y_control_node.set_step(0.0000001)
	_target_min_y_control_node.set_editable(true)
	_target_min_y_control_node.set_value(p_record.target_min.y)
	
	_target_max_x_control_node.set_step(0.0000001)
	_target_max_x_control_node.set_editable(true)
	_target_max_x_control_node.set_value(p_record.target_max.x)
	
	_target_max_y_control_node.set_step(0.0000001)
	_target_max_y_control_node.set_editable(true)
	_target_max_y_control_node.set_value(p_record.target_max.y)

func _on_headpart_type_selected( p_id ):
	if(current_record):
		current_record.headpart_type = p_id
		_headpart_type_control_node.set_text(headpart_record_const.get_string_from_headpart(current_record.headpart_type))
		current_database.mark_database_as_modified()

func _on_MeshFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.mesh_path = p_path
		current_database.mark_database_as_modified()

func _on_TextureFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.texture_path = p_path
		current_database.mark_database_as_modified()
		
		update_main_texture_preview(current_record)
		
func _on_GenMorphFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.gen_morph_path = p_path
		current_database.mark_database_as_modified()
		
func _on_TargetMinXSpinbox_value_changed( value ):
	if(current_record):
		current_record.target_min.x = float(value)
		current_database.mark_database_as_modified()

func _on_TargetMinYSpinbox_value_changed( value ):
	if(current_record):
		current_record.target_min.y = float(value)
		current_database.mark_database_as_modified()

func _on_TargetMaxXSpinbox_value_changed( value ):
	if(current_record):
		current_record.target_max.x = float(value)
		current_database.mark_database_as_modified()

func _on_TargetMaxYSpinbox_value_changed( value ):
	if(current_record):
		current_record.target_max.y = float(value)
		current_database.mark_database_as_modified()
