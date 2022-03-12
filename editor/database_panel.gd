@tool
extends Control

var database_records: Node = null
var galatea_databases: RefCounted = null
var editor_plugin: EditorPlugin = null
var current_database: RefCounted = null
var current_record: RefCounted = null
##
signal new_record_duplicate()

signal new_record_add_successful(p_current_database, p_record)
signal rename_record_successful(p_current_database, p_record)
signal erase_record_successful(p_current_database, p_record)

func setup_data():
	var tree = get_tree()
	if tree:
		if(tree.has_group("database_editor_root")):
			galatea_databases = tree.get_nodes_in_group("database_editor_root")[0].get_galatea_databases()
			editor_plugin = tree.get_nodes_in_group("database_editor_root")[0].get_editor_plugin()
	if(galatea_databases):
		galatea_databases_assigned()
	
func galatea_databases_assigned():
	database_records = get_node("LeftSide/DatabaseRecords")
	assert(database_records)
	
	if not(is_connected("new_record_duplicate", Callable(database_records, "new_record_duplicate_callback"))):
		assert(connect("new_record_duplicate", Callable(database_records, "new_record_duplicate_callback")) == OK)
		
	if not(is_connected("new_record_add_successful", Callable(database_records, "new_record_add_successful_callback"))):
		assert(connect("new_record_add_successful", Callable(database_records, "new_record_add_successful_callback")) == OK)
		
	if not(is_connected("rename_record_successful", Callable(database_records, "rename_record_successful_callback"))):
		assert(connect("rename_record_successful", Callable(database_records, "rename_record_successful_callback")) == OK)
		
	if not(is_connected("erase_record_successful", Callable(database_records, "erase_record_successful_callback"))):
		assert(connect("erase_record_successful", Callable(database_records, "erase_record_successful_callback")) == OK)
	
func set_galatea_databases(p_databases):
	galatea_databases = p_databases
	if(galatea_databases):
		galatea_databases_assigned()

func _ready():
	call_deferred("setup_data")

func submit_new_record_callback(p_name):
	if(galatea_databases):
		if(current_database):
			var original_record = galatea_databases.find_record_by_name(p_name)
			
			if(original_record != null):
				emit_signal("new_record_duplicate")
			else:
				var record = current_database.create_new_record(p_name)
				emit_signal("new_record_add_successful", current_database, record)
				current_database.mark_database_as_modified(current_database.DATABASE_NAME)
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
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
	else:
		printerr("galatea_databases is null")
		
func submit_erase_record_callback(p_name):
	if(galatea_databases):
		if(current_database):
			current_database.erase_record(p_name)
			emit_signal("erase_record_successful", current_database)
		else:
			printerr("current_database is null")
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
	else:
		printerr("galatea_databases is null")
		
func set_current_record_callback(p_record):
	current_record = p_record
