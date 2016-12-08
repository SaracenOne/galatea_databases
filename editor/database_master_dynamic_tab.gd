tool
extends TabContainer

export(bool) var is_root = false
var last_selected_tab = -1

var galatea_databases = null
var editor_plugin = null

func setup():
	last_selected_tab = get_current_tab()
	connect("tab_changed", self, "tab_changed")
	if(is_root):
		create_tab()

func tab_changed(p_tab):
	var current_tab = p_tab
	var child = get_child(last_selected_tab)
	if(child.has_method("erase_tab")):
		child.call("erase_tab")
		
	last_selected_tab = current_tab
	child = get_child(current_tab)
	if(child.has_method("create_tab")):
		child.call("create_tab")
		
func create_tab():
	var child = get_child(last_selected_tab)
	if(child):
		if(child.has_method("create_tab")):
			child.call("create_tab")
		
func erase_tab():
	for child in get_children():
		if(child.has_method("erase_tab")):
			child.call("erase_tab")
			
func set_galatea_databases(p_databases):
	galatea_databases = p_databases
	for child in get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)