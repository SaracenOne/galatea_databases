tool
extends Control

var galatea_databases = null
var current_database = null
var current_record = null
##
signal new_record_duplicate()

signal new_record_add_successful(p_current_database, p_record)
signal rename_record_successful(p_current_database, p_record)
signal erase_record_successful(p_current_database, p_record)

func submit_new_record_callback(p_name):
	if(galatea_databases):
		if(current_database):
			var original_name = current_database.find_record_by_name(p_name)
			
			if(original_name != null):
				emit_signal("new_record_duplicate_callback")
			else:
				var record = current_database.create_new_record(p_name)
				emit_signal("new_record_add_successful", current_database, record)
				
			current_database.mark_database_as_modified()
		else:
			printerr("current_database is null")
	else:
		printerr("galatea_databases is null")
		
	
func submit_renamed_record_callback(p_from, p_to):
	if(galatea_databases):
		if(current_database):
			var original_name = current_database.find_record_by_name(p_from)

			var record = current_database.rename_record(p_from, p_to)
			emit_signal("rename_record_successful", current_database, record)
		else:
			printerr("current_database is null")
		
		current_database.mark_database_as_modified()
	else:
		printerr("galatea_databases is null")
		
func submit_erase_record_callback(p_name):
	if(galatea_databases):
		if(current_database):
			current_database.erase_record(p_name)
			emit_signal("erase_record_successful", current_database)
		else:
			printerr("current_database is null")
		
		current_database.mark_database_as_modified()
	else:
		printerr("galatea_databases is null")
		
func set_current_record_callback(p_record):
	current_record = p_record

func set_galatea_databases(p_galatea_databases):
	galatea_databases = p_galatea_databases
	
	if(has_method("galatea_databases_assigned")):
		galatea_databases_assigned()