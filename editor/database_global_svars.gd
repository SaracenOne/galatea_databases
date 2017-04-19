tool
extends "database_panel.gd"

const global_svar_record_const = preload("../databases/global_svar_record.gd")

export(NodePath) var svar_type = NodePath()
export(NodePath) var svar_value_line_edit = NodePath()
export(NodePath) var svar_value_spinbox = NodePath()
export(NodePath) var svar_value_checkbox = NodePath()

onready var _svar_type_node = get_node(svar_type)
onready var _svar_value_line_edit_node = get_node(svar_value_line_edit)
onready var _svar_value_spinbox_node = get_node(svar_value_spinbox)
onready var _svar_value_checkbox_node = get_node(svar_value_checkbox)

func svar_type_selected(p_id):
	if(current_record and p_id != current_record.type):
		current_record.type = p_id
		set_type(p_id)
		
		if(p_id == global_svar_record_const.SVAR_TYPE_INTEGER):
			current_record.value = int(0)
			_svar_value_spinbox_node.set_value(0)
		elif (p_id == global_svar_record_const.SVAR_TYPE_FLOAT):
			current_record.value = float(0.0)
			_svar_value_spinbox_node.set_value(0.0)
		elif(p_id == global_svar_record_const.SVAR_TYPE_STRING):
			current_record.value = ""
			_svar_value_line_edit_node.set_text("")
		elif(p_id == global_svar_record_const.SVAR_TYPE_BOOLEAN):
			current_record.value = false
			_svar_value_checkbox_node.set_pressed(false)
			
		current_database.mark_database_as_modified()

func _ready():
	_svar_value_spinbox_node.set_step(0.0)
	
	if(_svar_type_node):
		var svar_type_popup = _svar_type_node.get_popup()
		svar_type_popup.connect("item_pressed", self, "svar_type_selected")
		
		var types = global_svar_record_const.get_array_of_types_as_strings()
		svar_type_popup.clear()
		for i in range(0, types.size()):
			svar_type_popup.add_item(types[i], i)

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.global_svar_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("global_svar_database is null")

func set_type(p_type):
	_svar_type_node.set_text(global_svar_record_const.svar_type_to_string(p_type))
	
	if(p_type == global_svar_record_const.SVAR_TYPE_INTEGER) or (p_type == global_svar_record_const.SVAR_TYPE_FLOAT):
		_svar_value_line_edit_node.hide()
		_svar_value_spinbox_node.show()
		_svar_value_checkbox_node.hide()
		if(p_type == global_svar_record_const.SVAR_TYPE_INTEGER):
			_svar_value_spinbox_node.set_step(1)
			_svar_value_spinbox_node.set_rounded_values(true)
		else:
			_svar_value_spinbox_node.set_step(0.00000001)
			_svar_value_spinbox_node.set_rounded_values(false)
	elif(p_type == global_svar_record_const.SVAR_TYPE_STRING):
		_svar_value_line_edit_node.show()
		_svar_value_spinbox_node.hide()
		_svar_value_checkbox_node.hide()
	elif(p_type == global_svar_record_const.SVAR_TYPE_BOOLEAN):
		_svar_value_line_edit_node.hide()
		_svar_value_spinbox_node.hide()
		_svar_value_checkbox_node.show()

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_svar_type_node.set_disabled(false)
	
	_svar_value_line_edit_node.set_editable(true)
	_svar_value_spinbox_node.set_editable(true)
	
	set_type(p_record.type)
	
	if(p_record.type == global_svar_record_const.SVAR_TYPE_INTEGER):
		_svar_value_spinbox_node.set_value(int(p_record.value))
	elif (p_record.type == global_svar_record_const.SVAR_TYPE_FLOAT):
		_svar_value_spinbox_node.set_value(float(p_record.value))
	elif(p_record.type == global_svar_record_const.SVAR_TYPE_STRING):
		_svar_value_line_edit_node.set_text(str(p_record.value))
	elif(p_record.type == global_svar_record_const.SVAR_TYPE_BOOLEAN):
		_svar_value_line_edit_node.set_text(str(p_record.value))

func _on_SvarValueSpinbox_value_changed( value ):
	if(current_record):
		if(current_record.type == global_svar_record_const.SVAR_TYPE_INTEGER):
			current_record.value = int(value)
		elif(current_record.type == global_svar_record_const.SVAR_TYPE_FLOAT):
			current_record.value = float(value)
		current_database.mark_database_as_modified()

func _on_SvarValueLineEdit_text_changed( text ):
	if(current_record):
		current_record.value = str(text)
		current_database.mark_database_as_modified()


func _on_SvarCheckBox_toggled( pressed ):
	if(current_record):
		current_record.value = pressed
		current_database.mark_database_as_modified()
