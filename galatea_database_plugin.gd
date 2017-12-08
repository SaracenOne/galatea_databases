tool
extends EditorPlugin

const compiler_const = preload("compiler/compiler.gd")
const galatea_databases_const = preload("databases/galatea_databases.gd")
const database_popup_const = preload("editor/database_popup.tscn")
const database_list_const_popup = preload("editor/database_list.tscn")
const record_instance_node_const = preload("instances/record_instance_node.gd")

var editor_interface = null
var galatea_databases = null

var galatea_database_path = "res://assets/database"
var database_popup_button = null
var select_record_button = null

var selected_node = null

var database_popup_instance = null
var database_list_instance = null

func _init():
	print("Setting up Galatea database plugin")
	
func save_external_data():
	if galatea_databases:
		print("Compiling databases...")
		compiler_const.compile_location_data(galatea_databases)

func handles(p_object):
	if p_object is record_instance_node_const:
		return true
	return false
	
func edit(p_object):
	selected_node = p_object
	
func make_visible(p_visible):
	if select_record_button:
		if (p_visible):
			select_record_button.show()
		else:
			select_record_button.hide()

func _enter_tree():
	editor_interface = get_editor_interface()
	galatea_databases = galatea_databases_const.new(galatea_database_path)
	
	galatea_databases.load_all_databases()
	
	database_popup_button = Button.new()
	database_popup_button.set_text("Database Editor")
	database_popup_button.set_tooltip("Open tool for editing Galatea's game databases.")
	database_popup_button.connect("pressed", self, "_database_popup_requested")
	
	add_control_to_container(CONTAINER_TOOLBAR, database_popup_button)
	
	select_record_button = Button.new()
	select_record_button.set_text("Select record...")
	select_record_button.set_tooltip("Choose a database record for this instance node.")
	select_record_button.connect("pressed", self, "_select_record_requested")
	select_record_button.hide()
	
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_MENU, select_record_button)
	
	# Nodes 
	add_custom_type("ActorInstance", "Spatial", preload("instances/actor_instance_node.gd"), null)
	add_custom_type("ItemInstance", "Spatial", preload("instances/item_instance_node.gd"), null)
	
func _exit_tree():
	if database_popup_button:
		database_popup_button.queue_free()
		database_popup_button.get_parent().remove_child(database_popup_button)
	
	if select_record_button:
		select_record_button.queue_free()
		select_record_button.get_parent().remove_child(database_popup_button)
	
	editor_interface = null
	galatea_databases = null
	
	_database_destroy_popup()
			
	# Nodes
	remove_custom_type("ActorInstance")
	remove_custom_type("ItemInstance")
	
func database_interface_assign_databases(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)
		database_interface_assign_databases(child)
		
func database_interface_assign_editor_plugin(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_editor_plugin")):
			child.call("set_editor_plugin", self)
		database_interface_assign_editor_plugin(child)
		
func _database_destroy_popup():
	if(database_popup_instance):
		if(database_popup_instance.is_connected("popup_hide", self, "database_popup_dismissed_callback")):
			database_popup_instance.disconnect("popup_hide", self, "database_popup_dismissed_callback")
		
		if(database_popup_instance.is_inside_tree()):
			database_popup_instance.queue_free()
			database_popup_instance = null
	
func database_popup_dismissed_callback():
	if(galatea_databases.check_database_modified()):
		print("The databases have been modified")
		_database_destroy_popup()
	else:
		print("The databases have not been modified")
		_database_destroy_popup()
	
func _database_popup_requested():
	_database_destroy_popup()
	
	database_popup_instance = database_popup_const.instance()
	database_popup_instance.connect("popup_hide", self, "database_popup_dismissed_callback")
	
	if(database_popup_instance):
		editor_interface.get_base_control().add_child(database_popup_instance)
		database_popup_instance.popup_centered()
		database_interface_assign_databases(database_popup_instance)
		database_interface_assign_editor_plugin(database_popup_instance)
	else:
		printerr("Could not load database editor scene")
		return FAILED
	
	return OK
	
func _select_record_requested():
	selected_node.set_databases(galatea_databases)
	var database = selected_node.get_valid_database()
	
	database_list_instance = database_list_const_popup.instance()
	editor_interface.get_base_control().add_child(database_list_instance)
	database_list_instance.connect("popup_hide", self, "_select_record_dismissed")
	database_list_instance.connect("record_selected", self, "_select_record_selected")
	database_list_instance.populate_tree(database)
	database_list_instance.popup_centered_ratio()
	
func _select_record_dismissed():
	if database_list_instance:
		if(database_list_instance.is_inside_tree()):
			database_list_instance.queue_free()
			database_list_instance = null
	
func _select_record_selected(p_record):
	get_undo_redo().create_action("selected database_entry")
	get_undo_redo().add_do_property(selected_node, "id", p_record.id)
	get_undo_redo().add_undo_property(selected_node, "id", selected_node.id)
	get_undo_redo().commit_action()
	_select_record_dismissed()