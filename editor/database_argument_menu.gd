@tool
extends Popup

var argument_tree: Tree = null
var method_arguments: Array = []
var template_arguments: Array = []

var id: int = -1

const methods_const = preload("../methods/methods.gd")

var databases = null
var database_list = preload("database_list.tscn").instantiate()
var database_numerical_menu = preload("database_numerical_menu.tscn").instantiate()
var database_text_input_menu = preload("database_text_input_menu.tscn").instantiate()
var database_enum_menu = preload("database_enum_menu.tscn").instantiate()
var database_boolean_menu = preload("database_boolean_menu.tscn").instantiate()

signal menu_dismissed

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("DatabaseListContainer/ButtonContainer/EditButton").set_disabled(true)
		
func assign_databases(p_databases):
	databases = p_databases
		
func set_arguments(p_method_arguments, p_template_arguments):
	if(argument_tree):
		argument_tree.clear()
		var root = argument_tree.create_item(null)
		argument_tree.set_hide_root(true)
	
		method_arguments = p_method_arguments
		template_arguments = p_template_arguments
		
		if(method_arguments.size() == template_arguments.size()):
			for i in range(0, template_arguments.size()):
				var tree_item = argument_tree.create_item(root)
				tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
				
				var argument = ""
				if(template_arguments[i].type == methods_const.ARGUMENT_TYPE_ENUM):
					var argument_enums = template_arguments[i].options["enums"]
					for argument_enum in argument_enums:
						if(argument_enum.option_value == (method_arguments[i])):
							argument = argument_enum.option_name
							break
				elif(template_arguments[i].type == methods_const.ARGUMENT_TYPE_OBJECT):
					if(method_arguments[i] == null):
						argument = "nil"
					else:
						argument = str(method_arguments[i].id)
				else:
					argument = str(method_arguments[i])
				
				tree_item.set_text(0, template_arguments[i].name + " = " + argument)
				tree_item.set_metadata(0, i)
		
func confirm_argument_selection(p_value):
	method_arguments[id] = p_value
	set_arguments(method_arguments, template_arguments)
		
func _ready():
	argument_tree = get_node("DatabaseListContainer/ArgumentTree")
	assert(argument_tree)
	
	argument_tree.set_select_mode(Tree.SELECT_SINGLE)
	
	database_enum_menu.connect("enum_selected", Callable(self, "confirm_argument_selection"))
	database_numerical_menu.connect("value_selected", Callable(self, "confirm_argument_selection"))
	database_text_input_menu.connect("text_selected", Callable(self, "confirm_argument_selection"))
	database_boolean_menu.connect("boolean_selected", Callable(self, "confirm_argument_selection"))
	database_list.connect("record_selected", Callable(self, "confirm_argument_selection"))
	
	add_child(database_list)
	add_child(database_numerical_menu)
	add_child(database_text_input_menu)
	add_child(database_enum_menu)
	add_child(database_boolean_menu)
	
func _on_ArgumentTree_cell_selected():
	if(argument_tree):
		var tree_item = argument_tree.get_selected()
		if(tree_item):
			get_node("DatabaseListContainer/ButtonContainer/EditButton").set_disabled(false)
			
func _on_EditButton_pressed():
	if(argument_tree):
		var tree_item = argument_tree.get_selected()
		if(tree_item):
			id = tree_item.get_metadata(0)
			var argument = template_arguments[id]
			
			if(argument.type == methods_const.ARGUMENT_TYPE_ENUM):
				var argument_enums = argument.options["enums"]
				var names = []
				var values = []
				names.resize(argument_enums.size())
				values.resize(argument_enums.size())
				
				for i in range(0, argument_enums.size()):
					names[i] = argument_enums[i].option_name
					values[i] = argument_enums[i].option_value
				
				database_enum_menu.set_enums(names, values)
				database_enum_menu.popup_centered()
			elif(argument.type == methods_const.ARGUMENT_TYPE_BOOL):
				database_boolean_menu.set_boolean(method_arguments[id])
				database_boolean_menu.popup_centered()
			elif(argument.type == methods_const.ARGUMENT_TYPE_FLOAT or argument.type == methods_const.ARGUMENT_TYPE_INT):
				
				if(argument.type == methods_const.ARGUMENT_TYPE_FLOAT):
					database_numerical_menu.set_step(0.00001)
				elif(argument.type == methods_const.ARGUMENT_TYPE_INT):
					database_numerical_menu.set_step(1.0)
					
				database_numerical_menu.set_value(method_arguments[id])
				database_numerical_menu.popup_centered()
			elif(argument.type == methods_const.ARGUMENT_TYPE_STRING):
				database_text_input_menu.set_text(method_arguments[id])
				database_text_input_menu.popup_centered()
			elif(argument.type == methods_const.ARGUMENT_TYPE_OBJECT):
				var database = databases.get(argument.options["database"])
				database_list.populate_tree(database)
				database_list.popup_centered()
			
				
func _on_BackButton_pressed():
	emit_signal("menu_dismissed")
	hide()
