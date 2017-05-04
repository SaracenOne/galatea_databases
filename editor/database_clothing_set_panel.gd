tool
extends "database_panel.gd"

export(NodePath) var clothes = NodePath()
export(NodePath) var printed_name = NodePath()

onready var _clothes_control = get_node(clothes)
onready var _printed_name_control = get_node(printed_name)

func _ready():
	pass
	
func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.clothing_set_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)

		_clothes_control.assign_database(galatea_databases.clothing_database)
	else:
		printerr("clothing_set_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	_printed_name_control.set_text(current_record.printed_name)
	_printed_name_control.set_editable(true)

	print(p_record.get_property_list())
	_clothes_control.set_disabled(false)
	_clothes_control.populate_tree(p_record.clothes, null)

func _on_ClothesControl_record_erased( p_record ):
	if(current_record):
		if(current_record.clothes.find(p_record) != -1):
			current_record.clothes.erase(p_record)
			_clothes_control.populate_tree(current_record.clothes, null)
			current_database.mark_database_as_modified()

func _on_ClothesControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.clothes.find(p_record) != -1):
			return
		else:
			current_record.clothes.append(p_record)
			_clothes_control.populate_tree(current_record.clothes, null)
			current_database.mark_database_as_modified()


func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()
