tool
extends Control

var galatea_databases = null
var editor_plugin = null

func set_galatea_databases(p_galatea_database):
	galatea_databases = p_galatea_database
	
func database_interface_assign_databases(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)
		database_interface_assign_databases(child)

func database_interface_assign_editor_plugin(p_control):
	print("YYY")
	for child in p_control.get_children():
		if(child.has_method("set_editor_plugin")):
			child.call("set_editor_plugin", galatea_databases)
		database_interface_assign_editor_plugin(child)

func _on_SaveButton_pressed():
	if(galatea_databases):
		galatea_databases.save_all_databases()

func _on_SettingsButton_pressed():
	pass

func _on_ReloadButton_pressed():
	if(galatea_databases):
		galatea_databases.load_all_databases()
		database_interface_assign_databases(self)