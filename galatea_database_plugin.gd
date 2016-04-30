tool
extends EditorPlugin

const galatea_databases_const = preload("databases/galatea_databases.gd")
const database_popup_const = preload("editor/database_popup.tscn")

var galatea_databases = null

var galatea_database_path = "res://assets/database"
var database_popup_button = null

var database_popup_instance = null

func _enter_tree():
	galatea_databases = galatea_databases_const.new(galatea_database_path)
	
	galatea_databases.load_all_databases()
	
	database_popup_button = Button.new()
	database_popup_button.set_text("Database Editor")
	database_popup_button.set_tooltip("Open tool for editing Galatea's game databases.")
	database_popup_button.connect("pressed", self, "database_popup_requested")
	
	add_control_to_container(CONTAINER_TOOLBAR, database_popup_button)
	
	# Nodes 
	add_custom_type("RecordInstance", "Position3D", preload("nodes/record_instance_node.gd"), null)
	
func _exit_tree():
	galatea_databases = null
	
	_database_destroy_popup()
			
	# Nodes
	remove_custom_type("Actor")
	
func database_interface_assign_databases(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_galatea_databases")):
			print(child.get_name())
			child.call("set_galatea_databases", galatea_databases)
		database_interface_assign_databases(child)
		
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
	
func database_popup_requested():
	_database_destroy_popup()
	
	database_popup_instance = database_popup_const.instance()
	database_popup_instance.connect("popup_hide", self, "database_popup_dismissed_callback")
	
	if(database_popup_instance):
		get_base_control().add_child(database_popup_instance)
		database_popup_instance.popup_centered()
		database_interface_assign_databases(database_popup_instance)
	else:
		printerr("Could not load database editor scene")
		return FAILED
	
	return OK