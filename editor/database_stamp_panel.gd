tool
extends "database_panel.gd"

export(NodePath) var texture_reference_control = NodePath()

export(NodePath) var target_min_x_control = NodePath()
export(NodePath) var target_min_y_control = NodePath()
export(NodePath) var target_max_x_control = NodePath()
export(NodePath) var target_max_y_control = NodePath()

export(NodePath) var uses_alpha_control = NodePath()
export(NodePath) var invert_alpha_control = NodePath()

onready var _texture_reference_control_node = get_node(texture_reference_control)

onready var _target_min_x_control_node = get_node(target_min_x_control)
onready var _target_min_y_control_node = get_node(target_min_y_control)
onready var _target_max_x_control_node = get_node(target_max_x_control)
onready var _target_max_y_control_node = get_node(target_max_y_control)
onready var _uses_alpha_control_node = get_node(uses_alpha_control)
onready var _invert_alpha_control_node = get_node(invert_alpha_control)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.stamp_database
	
	if(_texture_reference_control_node):
		_texture_reference_control_node.assign_database(galatea_databases.texture_set_database)

	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("stamp_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	if(_texture_reference_control_node):
		_texture_reference_control_node.set_disabled(false)
		if(p_record.texture_set):
			_texture_reference_control_node.set_record_name(p_record.texture_set.id)
		else:
			_texture_reference_control_node.set_record_name("")

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
	
	_uses_alpha_control_node.set_disabled(false)
	_uses_alpha_control_node.set_pressed(p_record.uses_alpha)
	
	_invert_alpha_control_node.set_disabled(false)
	_invert_alpha_control_node.set_pressed(p_record.invert_alpha)

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

func _on_UsesAlphaCheckBox_toggled( pressed ):
	if(current_record):
		current_record.uses_alpha = pressed
		current_database.mark_database_as_modified()
		
func _on_InvertAlphaCheckBox_toggled( pressed ):
	if(current_record):
		current_record.invert_alpha = pressed
		current_database.mark_database_as_modified()

func _on_TextureSetReference_record_selected( p_record ):
	if(current_record):
		current_record.texture_set = p_record
		current_database.mark_database_as_modified()

func _on_TextureSetReference_record_erased( p_record ):
	if(current_record):
		current_record.texture_set = p_record
		current_database.mark_database_as_modified()