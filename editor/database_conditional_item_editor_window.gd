extends Control
tool

const methods_const = preload("../methods/methods.gd")
var master_method_dict = null

const conditionals_const = preload("../conditionals/conditionals.gd")
var conditional_item = null

var databases = null

var svar_database_list = preload("database_list.tscn").instance()
var generic_list_popup = preload("database_generic_list.tscn").instance()
var database_argument_menu = preload("database_argument_menu.tscn").instance()

export(NodePath) var method_selection = NodePath()
export(NodePath) var arguments_selection = NodePath()
export(NodePath) var operator_selection = NodePath()

export(NodePath) var value_type_selection = NodePath()

export(NodePath) var value_spinbox = NodePath()
export(NodePath) var value_button = NodePath()
export(NodePath) var value_line_edit = NodePath()
export(NodePath) var value_checkbox = NodePath()

export(NodePath) var subject_selection = NodePath()
export(NodePath) var source_button = NodePath()

export(NodePath) var or_checkbox = NodePath()

onready var _method_selection_node = get_node(method_selection)
onready var _arguments_selection_node = get_node(arguments_selection)
onready var _operator_selection_node = get_node(operator_selection)

onready var _value_type_selection_node = get_node(value_type_selection)

onready var _value_spinbox_node = get_node(value_spinbox)
onready var _value_button_node = get_node(value_button)
onready var _value_line_edit_node = get_node(value_line_edit)
onready var _value_checkbox_node = get_node(value_checkbox)

onready var _subject_selection_node = get_node(subject_selection)
onready var _source_button_node = get_node(source_button)

onready var _or_checkbox_node = get_node(or_checkbox)

var method_selection_id = -1
var valid_method_list = []

signal confirmed(p_conditional_item)

func _spinbox_value_changed(p_value):
	if(conditional_item):
		conditional_item.value = p_value
		
func _checkbox_value_changed(p_value):
	if(conditional_item):
		conditional_item.value = p_value
		
func _svar_button_pressed():
	svar_database_list.populate_tree(databases.global_svar_database)
	svar_database_list.popup_centered()

func setup_controls():
	if(_method_selection_node):
		if(_method_selection_node.is_connected("pressed", self, "method_selection_pressed")):
			_method_selection_node.disconnect("pressed", self, "method_selection_pressed")
		_method_selection_node.connect("pressed", self, "method_selection_pressed")
		
	if(_arguments_selection_node):
		if(_arguments_selection_node.is_connected("pressed", self, "argument_selection_pressed")):
			_arguments_selection_node.disconnect("pressed", self, "argument_selection_pressed")
		_arguments_selection_node.connect("pressed", self, "argument_selection_pressed")
		
	if(_operator_selection_node):
		var operator_popup = _operator_selection_node.get_popup()
		operator_popup.clear()
		if(operator_popup.is_connected("id_pressed", self, "operator_type_selected")):
			operator_popup.disconnect("id_pressed", self, "operator_type_selected")
		operator_popup.connect("id_pressed", self, "operator_type_selected")
		var operator_string_array = conditionals_const.get_array_of_operator_strings()
		
		for i in range(0, operator_string_array.size()):
			operator_popup.add_item(operator_string_array[i], i)
			
	if(_value_button_node):
		_value_button_node.connect("pressed", self, "_svar_button_pressed")
			
	if(_value_spinbox_node):
		_value_spinbox_node.connect("value_changed", self, "_spinbox_value_changed")
		
	if(_value_checkbox_node):
		_value_checkbox_node.connect("toggled", self, "_checkbox_value_changed")
			
	if(_value_type_selection_node):
		var value_type_popup = _value_type_selection_node.get_popup()
		value_type_popup.clear()
		if(value_type_popup.is_connected("id_pressed", self, "value_type_selected")):
			value_type_popup.disconnet("id_pressed", self, "value_type_selected")
		value_type_popup.connect("id_pressed", self, "value_type_selected")
		var value_type_string_array = conditionals_const.get_array_of_value_type_strings()
		
		for i in range(0, value_type_string_array.size()):
			value_type_popup.add_item(value_type_string_array[i], i)
			
	if(_subject_selection_node):
		var subject_selection_popup = _subject_selection_node.get_popup()
		if(subject_selection_popup.is_connected("id_pressed", self, "subject_selected")):
			subject_selection_popup.disconnect("id_pressed", self, "subject_selected")
		subject_selection_popup.connect("id_pressed", self, "subject_selected")
		var subject_string_array = conditionals_const.get_array_of_subjects()
		
		subject_selection_popup.clear()
		for i in range(0, subject_string_array.size()):
			subject_selection_popup.add_item(subject_string_array[i], i)
		
	if(_or_checkbox_node):
		if(_or_checkbox_node.is_connected("toggled", self, "or_checkbox_toggled")):
			_or_checkbox_node.disconnect("toggled", self, "or_checkbox_toggled")
		_or_checkbox_node.connect("toggled", self, "or_checkbox_toggled")

func set_value_type(p_value_type):
	if(conditional_item):
		conditional_item.value_type == p_value_type
		
	if(p_value_type == conditionals_const.VALUE_TYPE_FLOAT):
		if(_value_spinbox_node):
			_value_spinbox_node.show()
		if(_value_button_node):
			_value_button_node.hide()
		if(_value_line_edit_node):
			_value_line_edit_node.hide()
		if(_value_checkbox_node):
			_value_checkbox_node.hide()
			
		_value_spinbox_node.set_value(conditional_item.value)
	elif(p_value_type == conditionals_const.VALUE_TYPE_STRING):
		if(_value_spinbox_node):
			_value_spinbox_node.hide()
		if(_value_button_node):
			_value_button_node.hide()
		if(_value_line_edit_node):
			_value_line_edit_node.show()
		if(_value_checkbox_node):
			_value_checkbox_node.hide()
			
		_value_line_edit_node.set_text(str(conditional_item.value))
	elif(p_value_type == conditionals_const.VALUE_TYPE_SVAR):
		if(_value_spinbox_node):
			_value_spinbox_node.hide()
		if(_value_button_node):
			_value_button_node.show()
		if(_value_line_edit_node):
			_value_line_edit_node.hide()
		if(_value_checkbox_node):
			_value_checkbox_node.hide()
			
		_value_button_node.set_text(str(conditional_item.value))
	elif(p_value_type == conditionals_const.VALUE_TYPE_BOOLEAN):
		if(_value_spinbox_node):
			_value_spinbox_node.hide()
		if(_value_button_node):
			_value_button_node.hide()
		if(_value_line_edit_node):
			_value_line_edit_node.hide()
		if(_value_checkbox_node):
			_value_checkbox_node.show()

		_value_checkbox_node.set_pressed(conditional_item.value)
		
func set_subject(p_subject):
	pass

func set_state_from_conditional_item():
	if(conditional_item):
		if(_method_selection_node):
			_method_selection_node.set_text(conditional_item.conditional_method)
		
		if(_operator_selection_node):
			_operator_selection_node.set_text(conditionals_const.operator_to_string(conditional_item.operator))
		
		if(_value_type_selection_node):
			_value_type_selection_node.set_text(conditionals_const.value_type_to_string(conditional_item.value_type))
			set_value_type(conditional_item.value_type)
			
		if(_subject_selection_node):
			_subject_selection_node.set_text(conditionals_const.subject_to_string(conditional_item.subject))
			set_subject(conditional_item.subject)
			
		if(_or_checkbox_node):
			_or_checkbox_node.set_pressed(conditional_item.use_or)
			
		var method_item = null
		if(master_method_dict.has(conditional_item.conditional_method)):
			method_item = master_method_dict[conditional_item.conditional_method]
			
		if(_arguments_selection_node):
			_arguments_selection_node.set_text(get_arguments_string(method_item))

func assign_conditional_item(p_conditional_item, p_databases):
	conditional_item = p_conditional_item
	databases = p_databases
	set_state_from_conditional_item()

func _ready():
	setup_controls()
	master_method_dict = methods_const.get_master_method_dict()
	
	svar_database_list.connect("record_selected", self, "confirm_svar_selection")
	
	add_child(generic_list_popup)
	add_child(database_argument_menu)
	add_child(svar_database_list)
		
func method_selection_pressed():
	var method_list = []
	for method_key in master_method_dict.keys():
		var method = {}
		method["name"] = method_key
		method["data"] = method_key
		method_list.append(method)
		
	if(method_list.size() > 0):
		generic_list_popup.connect("popup_hide", self, "_method_selection_hidden")
		generic_list_popup.connect("list_item_selected", self, "_on_method_selected")
	
		generic_list_popup.populate_tree(method_list)
		generic_list_popup.popup_centered_ratio()
		
func get_arguments_string(p_method_item):
	var string = ""
	if(conditional_item.arguments.size() > 0):
		for i in range(0, conditional_item.arguments.size()):
			var new_argument = ""
			if(p_method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_ENUM):
				new_argument = ""
				var argument_enums = p_method_item.arguments[i].options["enums"]
				
				for argument_enum in argument_enums:
					if(argument_enum.option_value == (conditional_item.arguments[i])):
						new_argument = argument_enum.option_name
						break
						
			elif(p_method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_OBJECT):
				if(conditional_item.arguments[i]):
					new_argument = str(conditional_item.arguments[i].id)
				else:
					new_argument = ""
			else:
				new_argument = str(conditional_item.arguments[i])
			
			if(i == conditional_item.arguments.size()-1):
				string += str(new_argument)
			else:
				string += str(new_argument) + ", "
	else:
		string = "nil"
		
	return string
		
func _on_method_selected(p_method):
	if(conditional_item):
		conditional_item.conditional_method = p_method
		
		var method_item = master_method_dict[conditional_item.conditional_method]
		conditional_item.arguments = []
		conditional_item.arguments.resize(method_item.arguments.size())
		
		if(_method_selection_node):
			_method_selection_node.set_text(conditional_item.conditional_method)
			
		for i in range(0, conditional_item.arguments.size()):
			if(conditional_item.arguments[i] == null):
				if(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_ENUM):
					var argument_enums = method_item.arguments[i].options["enums"]
					conditional_item.arguments[i] = argument_enums[0].option_value
				elif(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_BOOL):
					conditional_item.arguments[i] = false
				elif(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_FLOAT):
					conditional_item.arguments[i] = 0.0
				elif(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_INT):
					conditional_item.arguments[i] = 0
				elif(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_STRING):
					conditional_item.arguments[i] = ""
				elif(method_item.arguments[i].type == methods_const.ARGUMENT_TYPE_OBJECT):
					conditional_item.arguments[i] = null
			
		_arguments_selection_node.set_text(get_arguments_string(method_item))
	
func _method_selection_hidden():
	if(generic_list_popup.is_connected("popup_hide", self, "_method_selection_hidden")):
		generic_list_popup.disconnect("popup_hide", self, "_method_selection_hidden")
	
	if(generic_list_popup.is_connected("list_item_selected", self, "_on_method_selected")):
		generic_list_popup.disconnect("list_item_selected", self, "_on_method_selected")
		
func argument_menu_dismissed():
	database_argument_menu.disconnect("menu_dismissed", self, "argument_menu_dismissed")
	
	if(conditional_item):
		var method_item = master_method_dict[conditional_item.conditional_method]
		_arguments_selection_node.set_text(get_arguments_string(method_item))

func argument_selection_pressed():
	if(conditional_item and conditional_item.conditional_method):
		var method_item = master_method_dict[conditional_item.conditional_method]
		if(method_item.arguments.size() > 0):
			database_argument_menu.set_arguments(conditional_item.arguments, method_item.arguments)
			database_argument_menu.assign_databases(databases)
			if(!database_argument_menu.is_connected("menu_dismissed", self, "argument_menu_dismissed")):
				database_argument_menu.connect("menu_dismissed", self, "argument_menu_dismissed")
			database_argument_menu.popup_centered_ratio()
	
func operator_type_selected(p_id):
	if(conditional_item):
		conditional_item.operator = p_id
	_operator_selection_node.set_text(conditionals_const.operator_to_string(p_id))
	
func value_type_selected(p_id):
	if(conditional_item):
		conditional_item.value_type = p_id
		if(p_id == conditionals_const.VALUE_TYPE_FLOAT):
			conditional_item.value = 1.0
		elif(p_id == conditionals_const.VALUE_TYPE_STRING):
			conditional_item.value = ""
		elif(p_id == conditionals_const.VALUE_TYPE_SVAR):
			conditional_item.value = ""
		elif(p_id == conditionals_const.VALUE_TYPE_BOOLEAN):
			conditional_item.value = true
	_value_type_selection_node.set_text(conditionals_const.value_type_to_string(p_id))
	
	set_value_type(p_id)
	
func subject_selected(p_id):
	if(conditional_item):
		conditional_item.subject = p_id
	_subject_selection_node.set_text(conditionals_const.subject_to_string(p_id))
	
	set_subject(p_id)
	
func or_checkbox_toggled(p_toggled):
	if(conditional_item):
		conditional_item.use_or = p_toggled

func _on_ConfirmButton_pressed():
	emit_signal("confirmed", conditional_item)
	hide()

func _on_CancelButton_pressed():
	hide()
			
func confirm_svar_selection(p_svar_record):
	if(conditional_item and p_svar_record):
		conditional_item.value = p_svar_record.id
		_value_button_node.set_text(conditional_item.value)