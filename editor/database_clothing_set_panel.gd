tool
extends "database_panel.gd"
#
var database_records = null

export(NodePath) var clothing = NodePath()
export(NodePath) var printed_name = NodePath()

onready var _clothing_control = get_node(clothing)
onready var _printed_name_control = get_node(printed_name)

func _ready():
	pass
	
func galatea_databases_assigned():
	database_records = get_node("LeftSide/DatabaseRecords")
	assert(database_records)

	if not(is_connected("new_record_duplicate", database_records, "new_record_duplicate_callback")):
		connect("new_record_duplicate", database_records, "new_record_duplicate_callback")

	if not(is_connected("new_record_add_successful", database_records, "new_record_add_successful_callback")):
		connect("new_record_add_successful", database_records, "new_record_add_successful_callback")

	if not(is_connected("rename_record_successful", database_records, "rename_record_successful_callback")):
		connect("rename_record_successful", database_records, "rename_record_successful_callback")

	if not(is_connected("erase_record_successful", database_records, "erase_record_successful_callback")):
		connect("erase_record_successful", database_records, "erase_record_successful_callback")

	current_database = galatea_databases.clothing_set_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)

		_clothing_control.assign_database(galatea_databases.clothing_database)
	else:
		printerr("clothing_set_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	_printed_name_control.set_text(current_record.printed_name)
	_printed_name_control.set_editable(true)

	_clothing_control.set_disabled(false)
	_clothing_control.populate_tree(p_record.clothing, null)

func _on_ClothesControl_record_erased( p_record ):
	if(current_record):
		if(current_record.clothing.find(p_record) != -1):
			current_record.clothing.erase(p_record)
			_clothing_control.populate_tree(current_record.clothing, null)
			current_database.mark_database_as_modified()

func _on_ClothesControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.clothing.find(p_record) != -1):
			return
		else:
			current_record.clothing.append(p_record)
			_clothing_control.populate_tree(current_record.clothing, null)
			current_database.mark_database_as_modified()


func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()
