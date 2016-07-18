extends Control

const methods_const = preload("../methods/methods.gd")
var master_method_dict = null

const conditionals_const = preload("../conditionals/conditionals.gd")
var conditional_item = null

var generic_list_popup = preload("database_generic_list.tscn").instance()

export(NodePath) var method_selection = NodePath()
export(NodePath) var arguments_selection = NodePath()
export(NodePath) var operator_selection = NodePath()

export(NodePath) var value_type_selection = NodePath()

export(NodePath) var value_spinbox = NodePath()
export(NodePath) var value_button = NodePath()
export(NodePath) var value_line_edit = NodePath()

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

onready var _subject_selection_node = get_node(subject_selection)
onready var _source_button_node = get_node(source_button)

onready var _or_checkbox_node = get_node(or_checkbox)

var method_selection_id = -1
var valid_method_list = []

signal confirmed(p_conditional_item)

func _spinbox_value_changed(p_value):
	if(conditional_item):
		conditional_item.value = p_value

func setup_controls():
	if(_method_selection_node):
		_method_selection_node.connect("pressed", self, "method_selection_pressed")
		
	if(_arguments_selection_node):
		_arguments_selection_node.connect("pressed", self, "argument_selection_pressed")
		
	if(_operator_selection_node):
		var operator_popup = _operator_selection_node.get_popup()
		operator_popup.connect("item_pressed", self, "operator_type_selected")
		var operator_string_array = conditionals_const.get_array_of_operator_strings()
		
		for i in range(0, operator_string_array.size()):
			operator_popup.add_item(operator_string_array[i], i)
			
	if(_value_spinbox_node):
		_value_spinbox_node.connect("value_changed", self, "_spinbox_value_changed")
			
	if(_value_type_selection_node):
		var value_type_popup = _value_type_selection_node.get_popup()
		value_type_popup.connect("item_pressed", self, "value_type_selected")
		var value_type_string_array = conditionals_const.get_array_of_value_type_strings()
		
		for i in range(0, value_type_string_array.size()):
			value_type_popup.add_item(value_type_string_array[i], i)
			
	if(_subject_selection_node):
		var subject_selection_popup = _subject_selection_node.get_popup()
		subject_selection_popup.connect("item_pressed", self, "subject_selected")
		var subject_string_array = conditionals_const.get_array_of_subjects()
		
		for i in range(0, subject_string_array.size()):
			subject_selection_popup.add_item(subject_string_array[i], i)
		
	if(_or_checkbox_node):
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
			
		_value_spinbox_node.set_value(conditional_item.value)
	elif(p_value_type == conditionals_const.VALUE_TYPE_STRING):
		if(_value_spinbox_node):
			_value_spinbox_node.hide()
		if(_value_button_node):
			_value_button_node.hide()
		if(_value_line_edit_node):
			_value_line_edit_node.show()
			
		_value_line_edit_node.set_text(str(conditional_item.value))
	elif(p_value_type == conditionals_const.VALUE_TYPE_SVAR):
		if(_value_spinbox_node):
			_value_spinbox_node.hide()
		if(_value_button_node):
			_value_button_node.show()
		if(_value_line_edit_node):
			_value_line_edit_node.hide()
			
		_value_button_node.set_text(str(conditional_item.value))
		
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

func assign_conditional_item(p_conditional_item):
	conditional_item = p_conditional_item
	set_state_from_conditional_item()

func _ready():
	setup_controls()
	master_method_dict = methods_const.get_master_method_dict()
	
	add_child(generic_list_popup)
		
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
		
func _on_method_selected(p_method):
	if(conditional_item):
		conditional_item.conditional_method = p_method
		if(_method_selection_node):
			_method_selection_node.set_text(conditional_item.conditional_method)
	
func _method_selection_hidden():
	if(generic_list_popup.is_connected("popup_hide", self, "_method_selection_hidden")):
		generic_list_popup.disconnect("popup_hide", self, "_method_selection_hidden")
	
	if(generic_list_popup.is_connected("list_item_selected", self, "_on_method_selected")):
		generic_list_popup.disconnect("list_item_selected", self, "_on_method_selected")
	
func argument_selection_pressed():
	print("")
	
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