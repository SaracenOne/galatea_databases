tool
extends Control

var galatea_databases = null

func set_galatea_databases(p_galatea_database):
	galatea_databases = p_galatea_database
	
func database_interface_assign_databases(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)
		database_interface_assign_databases(child)

func _on_SaveButton_pressed():
	if(galatea_databases):
		galatea_databases.save_all_databases()

func _on_SettingsButton_pressed():
	pass

func _on_ReloadButton_pressed():
	if(galatea_databases):
		galatea_databases.load_all_databases()
		database_interface_assign_databases(self)