tool
extends "database_panel.gd"

const headpart_record_const = preload("../databases/headpart_record.gd")

export(NodePath) var mesh_file_control = NodePath()
export(NodePath) var gen_morph_file_control = NodePath()

export(NodePath) var target_min_x_control = NodePath()
export(NodePath) var target_min_y_control = NodePath()
export(NodePath) var target_max_x_control = NodePath()
export(NodePath) var target_max_y_control = NodePath()

export(NodePath) var scene_preview = NodePath()
export(NodePath) var capture_button = NodePath()

onready var _mesh_file_control_node = get_node(mesh_file_control)
onready var _gen_morph_file_control_node = get_node(gen_morph_file_control)

onready var _target_min_x_control_node = get_node(target_min_x_control)
onready var _target_min_y_control_node = get_node(target_min_y_control)
onready var _target_max_x_control_node = get_node(target_max_x_control)
onready var _target_max_y_control_node = get_node(target_max_y_control)

onready var _scene_preview_node = get_node(scene_preview)
onready var _capture_button_node = get_node(capture_button)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.meshpart_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("meshpart_database is null")

func orient_scene_preview():
	_scene_preview_node.rot_x = -20.0
	_scene_preview_node.rot_y = 45.0
	_scene_preview_node._update_rotation()

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	_mesh_file_control_node.set_file_path(p_record.mesh_path)
	_mesh_file_control_node.set_disabled(false)

	setup_scene_preview()

	_gen_morph_file_control_node.set_file_path(p_record.gen_morph_path)
	_gen_morph_file_control_node.set_disabled(false)

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
	
	_capture_button_node.set_disabled(false)
	_scene_preview_node.set_default_capture_filename(current_record.id + "_icon.png")

	##

func _on_MeshFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.mesh_path = p_path
		setup_scene_preview()
		current_database.mark_database_as_modified()

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

func setup_scene_preview():
	if(current_record.mesh_path != ""):
		var preview_mesh = load(current_record.mesh_path)
		if(preview_mesh and preview_mesh is Mesh):
			var preview_material = null
			
			if(_scene_preview_node):
				_scene_preview_node.set_mesh(preview_mesh)
				_scene_preview_node.set_material(preview_material)
		else:
			_scene_preview_node.set_mesh(null)
			_scene_preview_node.set_material(null)
			
		orient_scene_preview()


func _on_CreateIconButton_pressed():
	if _scene_preview_node and _capture_button_node:
		_scene_preview_node.save_preview_image()


func _on_OrientButton_pressed():
	orient_scene_preview()
