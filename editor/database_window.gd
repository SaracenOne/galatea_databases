@tool
extends Window

var galatea_databases = null
var editor_plugin = null

func set_editor_plugin(p_editor_plugin):
	editor_plugin = p_editor_plugin
	get_child(0).set_editor_plugin(editor_plugin)

func set_galatea_databases(p_galatea_database):
	galatea_databases = p_galatea_database
	get_child(0).set_galatea_databases(galatea_databases)
	
func database_interface_assign_databases(p_node: Node):
	for child in p_node.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)

func _on_database_window_about_to_popup():
	for tab in get_tree().get_nodes_in_group("database_editor_tab"):
		if(tab.has_method("setup")):
			tab.call("setup")
