@tool
extends "./database_panel.gd"

const body_scaler_const = preload("../data/body_scaler.gd")
const body_scaler_database_const = preload("../databases/body_scaler_database.gd")
const body_scaler_record_const = preload("../databases/body_scaler_record.gd")
#
@export var vector_control_x: NodePath  = NodePath()
@export var vector_control_y: NodePath  = NodePath()
@export var vector_control_z: NodePath  = NodePath()

@export var bone_tree_nodepath: NodePath  = NodePath()
@export var command_tree_nodepath: NodePath  = NodePath()

@export var type_selection_nodepath: NodePath  = NodePath()
@export var inverse_nodepath: NodePath  = NodePath()
@export var min_nodepath: NodePath  = NodePath()
@export var max_nodepath: NodePath  = NodePath()

@export var character_creator_nodepath: NodePath  = NodePath()
@export var printed_name_nodepath: NodePath  = NodePath()
@export var default_value_nodepath: NodePath  = NodePath()

@onready var _bone_tree_control_node = get_node(bone_tree_nodepath)
@onready var _command_tree_control_node = get_node(command_tree_nodepath)

@onready var _type_selection_control_node = get_node(type_selection_nodepath)
@onready var _x_vector_control_node = get_node(vector_control_x)
@onready var _y_vector_control_node = get_node(vector_control_y)
@onready var _z_vector_control_node = get_node(vector_control_z)

@onready var _inverse_control_node = get_node(inverse_nodepath)

@onready var _min_control_node = get_node(min_nodepath)
@onready var _max_control_node = get_node(max_nodepath)

@onready var _character_creator_node = get_node(character_creator_nodepath)
@onready var _printed_name_node = get_node(printed_name_nodepath)
@onready var _default_value_node = get_node(default_value_nodepath)

var bone = null
var command = null

func _ready():
	bone_new_edit_popup = preload("database_new_edit_record_popup.tscn").instantiate()
	bone_new_edit_popup.set_hide_on_ok(false)
	add_child(bone_new_edit_popup)

	error_dialog = AcceptDialog.new()
	error_dialog.set_exclusive(true)
	add_child(error_dialog)
	
	_type_selection_control_node.get_popup().connect("id_pressed", Callable(self, "type_selected"))

func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.body_scaler_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("body_scaler_database is null")

func set_current_record_callback(p_record):
	current_record = p_record

	bone = null
	command = null

	update_bone_tree()
	update_command_tree()
	update_command_data()
	
	_character_creator_node.set_disabled(false)
	_character_creator_node.set_pressed(current_record.character_creator)
	
	_printed_name_node.set_editable(true)
	_printed_name_node.set_text(current_record.printed_name)
	
	_default_value_node.set_step(0.00001)
	_default_value_node.set_editable(true)
	_default_value_node.set_value(current_record.default_value)

###

var bone_new_edit_popup = null
var error_dialog = null

func update_command_data():
	_command_tree_control_node = get_node("RightSide/BoneScalerArea/CommandsContainer/CommandsTree")
	
	if(current_record and bone and command):
		if(command.command_id == body_scaler_const.COMMAND_SCALE):
			_type_selection_control_node.set_text("Scale")
		elif(command.command_id == body_scaler_const.COMMAND_POSITION):
			_type_selection_control_node.set_text("Position")
		_type_selection_control_node.set_disabled(false)
		
		_x_vector_control_node.set_step(0.00001)
		_x_vector_control_node.set_value(command.command_value.x)
		
		_y_vector_control_node.set_step(0.00001)
		_y_vector_control_node.set_value(command.command_value.y)
		
		_z_vector_control_node.set_step(0.00001)
		_z_vector_control_node.set_value(command.command_value.z)
		
		_inverse_control_node.set_disabled(false)
		_inverse_control_node.set_pressed(command.inverse)
		
		_min_control_node.set_step(0.00001)
		_min_control_node.set_value(command.min_value)
		
		_max_control_node.set_step(0.00001)
		_max_control_node.set_value(command.max_value)
	else:
		_type_selection_control_node.set_text("")
		_type_selection_control_node.set_disabled(true)
		
		_x_vector_control_node.set_step(0.0)
		_x_vector_control_node.set_value(1.0)
		
		_y_vector_control_node.set_step(0.0)
		_y_vector_control_node.set_value(1.0)
		
		_z_vector_control_node.set_step(0.0)
		_z_vector_control_node.set_value(1.0)
		
		_inverse_control_node.set_pressed(false)
		
		_min_control_node.set_step(0.0)
		_min_control_node.set_value(0.0)
		
		_max_control_node.set_step(0.0)
		_max_control_node.set_value(1.0)

func update_bone_tree():
	_bone_tree_control_node = get_node("RightSide/BoneScalerArea/BonesContainer/BonesTree")
	_bone_tree_control_node.clear()
	var root = _bone_tree_control_node.create_item(null)
	_bone_tree_control_node.set_hide_root(true)

	if(current_record):
		for scaler_bone_key in current_record.scaler_bones.keys():
			var tree_item = _bone_tree_control_node.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, scaler_bone_key)
			tree_item.set_metadata(0, scaler_bone_key)

func update_command_tree():
	_command_tree_control_node.clear()
	var root = _command_tree_control_node.create_item(null)
	_command_tree_control_node.set_hide_root(true)

	if(current_record and bone):
		var integer = 0
		for scaler_command in bone.scaler_commands:
			var tree_item = _command_tree_control_node.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, str(integer))
			tree_item.set_metadata(0, scaler_command)
			integer += 1

func add_bone_name_received(p_string):
	bone_new_edit_popup.disconnect("name_entry_commit", Callable(self, "add_bone_name_received"))
	if(current_record):
		if(!current_record.scaler_bones.has(p_string)):
			current_record.scaler_bones[p_string] = body_scaler_const.ScalerBone.new()
			bone_new_edit_popup.hide()
			update_bone_tree()
			update_command_tree()
			
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func rename_bone_name_received(p_string):
	bone_new_edit_popup.disconnect("name_entry_commit", Callable(self, "rename_bone_name_received"))
	if(current_record):
		if(!current_record.scaler_bones.has(p_string)):
			var tree_item = _bone_tree_control_node.get_selected()
			current_record.scaler_bones[p_string] = current_record.scaler_bones[tree_item.get_metadata(0)]
			current_record.scaler_bones.erase(tree_item.get_metadata(0))
			
			bone_new_edit_popup.hide()
			update_bone_tree()
			update_command_tree()
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_AddBoneButton_pressed():
	if(current_record):
		bone_new_edit_popup.set_instructions_text("Please give a name for the bone...")
		bone_new_edit_popup.connect("name_entry_commit", Callable(self, "add_bone_name_received"))
		bone_new_edit_popup.popup_centered()

func _on_EraseBoneButton_pressed():
	if(current_record):
		var tree_item = _bone_tree_control_node.get_selected()
		if(tree_item):
			var key = tree_item.get_metadata(0)
			current_record.scaler_bones.erase(key)
			
			bone = null
			
			update_bone_tree()
			update_command_tree()

func _on_RenameBoneButton_pressed():
	if(current_record):
		var tree_item = _bone_tree_control_node.get_selected()
		if(tree_item):
			bone_new_edit_popup.set_instructions_text(str("Please give a new name for the bone named '%s'...") % (tree_item.get_text(0)))
			bone_new_edit_popup.connect("name_entry_commit", Callable(self, "rename_bone_name_received"))

			bone_new_edit_popup.popup_centered()

func _on_BonesTree_cell_selected():
	if(current_record):
		var tree_item = _bone_tree_control_node.get_selected()

		bone = current_record.scaler_bones[tree_item.get_metadata(0)]
		command = null

		update_command_tree()


func _on_CommandsTree_cell_selected():
	if(current_record):
		var tree_item = _command_tree_control_node.get_selected()
		command = tree_item.get_metadata(0)

		update_command_data()
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)


func _on_AddCommandButton_pressed():
	if(current_record and bone):
		var command = body_scaler_const.ScalerCommand.new()
		bone.scaler_commands.append(command)
		
		update_command_tree()
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_EraseCommandButton_pressed():
	if(current_record and bone):
		var tree_item = _command_tree_control_node.get_selected()
		if(tree_item):
			command = tree_item.get_metadata(0)
			if(command):
				bone.scaler_commands.erase(command)
				update_command_tree()
				
				current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func type_selected(p_id):
	if(current_record and bone and command):
		command.command_id = p_id
		update_command_data()
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_XVectorSpinBox_value_changed( value ):
	if(current_record and bone and command):
		command.command_value.x = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_YVectorSpinBox_value_changed( value ):
	if(current_record and bone and command):
		command.command_value.y = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_ZVectorSpinBox_value_changed( value ):
	if(current_record and bone and command):
		command.command_value.z = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_MinSpinbox_value_changed( value ):
	if(current_record and bone and command):
		command.min_value = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_MaxSpinbox_value_changed( value ):
	if(current_record and bone and command):
		command.max_value = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_InverseCheckBox_toggled( pressed ):
	if(current_record and bone and command):
		command.inverse = pressed
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_CharacterCreatorCheckBox_toggled( pressed ):
	if(current_record):
		current_record.character_creator = pressed
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_DefaultValueSpinbox_value_changed( value ):
	if(current_record):
		current_record.default_value = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
