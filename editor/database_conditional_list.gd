tool
extends Control

var list_tree = null

var database_new_edit_record_popup = null
var error_dialog = null

var assigned_conditionals = []
var selected = null

const conditionals_const = preload("../conditionals/conditionals.gd")

var conditional_item_editor_window = preload("database_conditional_item_editor_window.tscn").instance()

export(NodePath) var add_button = NodePath("ButtonPanel/ButtonContainer/AddButton")
export(NodePath) var edit_button = NodePath("ButtonPanel/ButtonContainer/EditButton")
export(NodePath) var duplicate_button = NodePath("ButtonPanel/ButtonContainer/DuplicateButton")
export(NodePath) var remove_button = NodePath("ButtonPanel/ButtonContainer/RemoveButton")
export(NodePath) var move_up_button = NodePath("ButtonPanel/ButtonContainer/MoveUpButton")
export(NodePath) var move_down_button = NodePath("ButtonPanel/ButtonContainer/MoveDownButton")

onready var _add_button_node = get_node(add_button)
onready var _edit_button_node = get_node(edit_button)
onready var _duplicate_button_node = get_node(duplicate_button)
onready var _remove_button_node = get_node(remove_button)
onready var _move_up_button_node = get_node(move_up_button)
onready var _move_down_button_node = get_node(move_down_button)

signal move_up(p_index)
signal move_down(p_index)

func _notification(what):
	pass
		
func assign_conditionals(p_conditional_array):
	assigned_conditionals = p_conditional_array
	populate_tree(assigned_conditionals)
		
func populate_tree(p_list):
	if(list_tree and p_list != null):
		
		var selected_conditional = null
		if(selected):
			selected_conditional = selected.get_metadata(0)
		
		list_tree.clear()
		var root = list_tree.create_item(null)
		list_tree.set_hide_root(true)
		
		for list_item in p_list:
			var string = ""
			
			if(list_item.conditional_method != ""):
				string += conditionals_const.process_on_to_string(list_item.process_on)
				string += "."
				string += list_item.conditional_method
				string += "("
				for argument in list_item.arguments:
					string += argument
					string += ", "
				string += ")"
				string += " "
				string += conditionals_const.operator_to_string(list_item.operator)
				string += " "
				string += str(list_item.value)
				if(list_item.use_or):
					string += " or"
				else:
					string += " and"
			else:
				string += "NO METHOD"
			
			var tree_item = list_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, string)
			tree_item.set_metadata(0, list_item)
			if(selected_conditional != null):
				if(selected_conditional == list_item):
					tree_item.select(0)
			
	else:
		printerr("List tree is null!")
		
func _ready():
	list_tree = get_node("ListTree")
	assert(list_tree)
	
	list_tree.set_select_mode(Tree.SELECT_SINGLE)

	list_tree.set_column_titles_visible(true) 
	list_tree.set_column_title(0, "Conditions")
	
	add_child(conditional_item_editor_window)

func _on_ListTree_cell_selected():
	if(list_tree):
		selected = list_tree.get_selected()
		
		update_button_states()

func update_button_states():
	if(_edit_button_node):
		if(selected):
			_edit_button_node.set_disabled(false)
		else:
			_edit_button_node.set_disabled(true)
	
	if(_duplicate_button_node):
		if(selected):
			_duplicate_button_node.set_disabled(false)
		else:
			_duplicate_button_node.set_disabled(true)
		
	if(_remove_button_node):
		if(selected):
			_remove_button_node.set_disabled(false)
		else:
			_remove_button_node.set_disabled(true)
		
	if(_move_up_button_node):
		if(selected and selected.get_prev()):
			_move_up_button_node.set_disabled(false)
		else:
			_move_up_button_node.set_disabled(true)
		
	if(_move_down_button_node):
		if(selected and selected.get_next()):
			_move_down_button_node.set_disabled(false)
		else:
			_move_down_button_node.set_disabled(true)

func _on_add_item_confirmed(p_conditional_item):
	if(p_conditional_item):
		assigned_conditionals.append(p_conditional_item)
		populate_tree(assigned_conditionals)
	
func _on_add_item_hidden():
	if(conditional_item_editor_window.is_connected("confirmed", self, "_on_add_item_confirmed")):
		conditional_item_editor_window.disconnect("confirmed", self, "_on_add_item_confirmed")
		
	if(conditional_item_editor_window.is_connected("popup_hide", self, "_on_add_item_hidden")):
		conditional_item_editor_window.disconnect("popup_hide", self, "_on_add_item_hidden")

func _on_AddButton_pressed():
	var conditional_item = conditionals_const.ConditionalItem.new()
		
	conditional_item_editor_window.connect("confirmed", self, "_on_add_item_confirmed")
	conditional_item_editor_window.connect("popup_hide", self, "_on_add_item_hidden")
	
	conditional_item_editor_window.assign_conditional_item(conditional_item)
	conditional_item_editor_window.popup_centered()
	
func _on_edit_item_confirmed(p_conditional_item):
	if(p_conditional_item):
		populate_tree(assigned_conditionals)
		update_button_states()
	
func _on_edit_item_hidden():
	if(conditional_item_editor_window.is_connected("confirmed", self, "_on_edit_item_confirmed")):
		conditional_item_editor_window.disconnect("confirmed", self, "_on_edit_item_confirmed")
		
	if(conditional_item_editor_window.is_connected("popup_hide", self, "_on_edit_item_hidden")):
		conditional_item_editor_window.disconnect("popup_hide", self, "_on_edit_item_hidden")

func _on_EditButton_pressed():
	if(selected):
		var conditional_item = selected.get_metadata(0)
		if(conditional_item):
			conditional_item_editor_window.connect("confirmed", self, "_on_edit_item_confirmed")
			conditional_item_editor_window.connect("popup_hide", self, "_on_edit_item_hidden")
			
			conditional_item_editor_window.assign_conditional_item(conditional_item)
			conditional_item_editor_window.popup_centered()

func _on_DuplicateButton_pressed():
	if(selected):
		var conditional_item = selected.get_metadata(0)
		if(conditional_item):
			var new_conditional = conditionals_const.ConditionalItem.new()
			new_conditional.copy(conditional_item)
				
			assigned_conditionals.insert(assigned_conditionals.find(conditional_item) + 1, new_conditional)
			populate_tree(assigned_conditionals)

func _on_RemoveButton_pressed():
	if(selected):
		var conditional_item = selected.get_metadata(0)
		if(conditional_item):
			if(selected.get_prev()):
				selected.get_prev().select(0)
			elif(selected.get_next()):
				selected.get_next().select(0)
			else:
				selected = null
				
			assigned_conditionals.remove(assigned_conditionals.find(conditional_item))
			populate_tree(assigned_conditionals)
			update_button_states()

func _on_MoveUp_pressed():
	if(selected):
		var conditional_item = selected.get_metadata(0)
		if(conditional_item):
			var index = assigned_conditionals.find(conditional_item)
			if(index > 0):
				assigned_conditionals.remove(index)
				assigned_conditionals.insert(index - 1, conditional_item)
				
				populate_tree(assigned_conditionals)
				update_button_states()
		
func _on_MoveDown_pressed():
	if(selected):
		var conditional_item = selected.get_metadata(0)
		if(conditional_item):
			var index = assigned_conditionals.find(conditional_item)
			if(index != -1 and index < assigned_conditionals.size()-1):
				assigned_conditionals.remove(index)
				assigned_conditionals.insert(index + 1, conditional_item)
				
				populate_tree(assigned_conditionals)
				update_button_states()
