tool
extends Control

var galatea_databases = null
var editor_plugin = null

func set_galatea_databases(p_galatea_database):
	galatea_databases = p_galatea_database
	
func set_editor_plugin(p_editor_plugin):
	editor_plugin = p_editor_plugin
	
func get_galatea_databases():
	return galatea_databases
	
func get_editor_plugin():
	return editor_plugin

func _on_SaveButton_pressed():
	if(galatea_databases):
		galatea_databases.save_all_databases()

func _on_SettingsButton_pressed():
	pass

func _on_ReloadButton_pressed():
	if(galatea_databases):
		galatea_databases.load_all_databases()
		database_interface_assign_databases(self)