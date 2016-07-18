var galatea_databases = null
var editor_plugin = null

func set_editor_plugin(p_editor_plugin):
	editor_plugin = p_editor_plugin
	get_child(0).database_interface_assign_editor_plugin(get_child(0))

func set_galatea_databases(p_galatea_database):
	galatea_databases = p_galatea_database