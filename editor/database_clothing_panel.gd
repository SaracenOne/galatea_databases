tool
extends "database_panel.gd"
#
var database_records = null
const clothing_record_const = preload("res://addons/galatea_databases/databases/clothing_record.gd")

var current_male_stamp_key = ""
var current_female_stamp_key = ""

export(NodePath) var printed_name = NodePath()
export(NodePath) var clothing_parts = NodePath()

export(NodePath) var male_stamp_table = NodePath()
export(NodePath) var male_stamp_color = NodePath()

export(NodePath) var female_stamp_table = NodePath()
export(NodePath) var female_stamp_color = NodePath()

export(NodePath) var biped = NodePath()

onready var _printed_name_control = get_node(printed_name)
onready var _clothing_parts_control = get_node(clothing_parts)

onready var _male_stamp_table_control = get_node(male_stamp_table)
onready var _male_stamp_color_control = get_node(male_stamp_color)

onready var _female_stamp_table_control = get_node(female_stamp_table)
onready var _female_stamp_color_control = get_node(female_stamp_color)

onready var _biped_control = get_node(biped)

func _ready():
	_biped_control = get_node("RightSide/BipedContainer/BipedTree")
	
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

	current_database = galatea_databases.clothing_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)
		
		_clothing_parts_control.assign_database(galatea_databases.clothing_part_database)
		_male_stamp_table_control.assign_database(galatea_databases.stamp_database)
		_female_stamp_table_control.assign_database(galatea_databases.stamp_database)
	else:
		printerr("clothing_database is null")
		
func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control.set_text(current_record.printed_name)
	_printed_name_control.set_editable(true)
	
	_clothing_parts_control.set_disabled(false)
	_clothing_parts_control.populate_tree(p_record.clothing_parts, null)
	
	var stamp_records = []
	for stamp_key in p_record.male_stamp_table.keys():
		var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
		if(record):
			stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
			
	_male_stamp_table_control.set_disabled(false)
	_male_stamp_table_control.populate_tree(stamp_records, null)
	_male_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
	_male_stamp_color_control.set_disabled(true)
	current_male_stamp_key = ""
			
	stamp_records = []
	for stamp_key in p_record.female_stamp_table.keys():
		var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
		if(record):
			stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
			
	_female_stamp_table_control.set_disabled(false)
	_female_stamp_table_control.populate_tree(stamp_records, null)
	_female_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
	_female_stamp_color_control.set_disabled(true)
	current_female_stamp_key = ""
	
	_biped_control.set_hide_root(true)
	_biped_control.clear()
	var root = _biped_control.create_item()
	for i in range(0, clothing_record_const.biped_name_array.size()):
		var item = _biped_control.create_item(root)
		item.set_cell_mode(0, TreeItem.CELL_MODE_CHECK)
		item.set_text(0, str(clothing_record_const.biped_name_array[i]))
		item.set_editable(0, true)
		item.set_checked(0, current_record.biped_flags & (1 << i))
	
func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()
		
func _on_ClothingPartsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.clothing_parts.find(p_record) != -1):
			current_record.clothing_parts.erase(p_record)
			_clothing_parts_control.populate_tree(current_record.clothing_parts, null)
			current_database.mark_database_as_modified()
			
func _on_ClothingPartsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.clothing_parts.find(p_record) != -1):
			return
		else:
			current_record.clothing_parts.append(p_record)
			_clothing_parts_control.populate_tree(current_record.clothing_parts, null)
			current_database.mark_database_as_modified()
			
func _on_MaleStampTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_male_stamp_key = p_record.id
		
		if(current_record.male_stamp_table.has(p_record.id) == true):
			_male_stamp_color_control.set_color(current_record.male_stamp_table[p_record.id])
		else:
			_male_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
		_male_stamp_color_control.set_disabled(false)
	else:
		current_male_stamp_key = ""
		
func _on_MaleStampTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.male_stamp_table.has(p_record.id) == true):
			current_record.male_stamp_table.erase(p_record.id)
			
			var stamp_records = []
			for stamp_key in current_record.male_stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
				if(record):
					stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
			
			current_male_stamp_key = ""
			_male_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_male_stamp_color_control.set_disabled(true)
			
			_male_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()
			
func _on_MaleStampTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.male_stamp_table.has(p_record.id) == true):
			return
		else:
			current_record.male_stamp_table[p_record.id] = Color(1.0, 1.0, 1.0)
			
			var stamp_records = []
			for stamp_key in current_record.male_stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
				if(record):
					stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
					
			current_male_stamp_key = ""
			_male_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_male_stamp_color_control.set_disabled(false)
			
			_male_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()

func _on_MaleStampColorButton_color_changed( color ):
	if(current_record):
		if(_male_stamp_color_control):
			if(current_male_stamp_key != ""):
				if(current_record.male_stamp_table.has(current_male_stamp_key) == true):
					current_record.male_stamp_table[current_male_stamp_key] = color
					
					current_database.mark_database_as_modified()

func _on_FemaleStampTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_female_stamp_key = p_record.id
		
		if(current_record.female_stamp_table.has(p_record.id) == true):
			_female_stamp_color_control.set_color(current_record.female_stamp_table[p_record.id])
		else:
			_female_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
		_female_stamp_color_control.set_disabled(false)
	else:
		current_female_stamp_key = ""

func _on_FemaleStampTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.female_stamp_table.has(p_record.id) == true):
			current_record.female_stamp_table.erase(p_record.id)
			
			var stamp_records = []
			for stamp_key in current_record.female_stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
				if(record):
					stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
			
			current_male_stamp_key = ""
			_female_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_female_stamp_color_control.set_disabled(true)
			
			_female_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()

func _on_FemaleStampTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.female_stamp_table.has(p_record.id) == true):
			return
		else:
			current_record.female_stamp_table[p_record.id] = Color(1.0, 1.0, 1.0)
			
			var stamp_records = []
			for stamp_key in current_record.female_stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp_key)
				if(record):
					stamp_records.append(galatea_databases.stamp_database.find_record_by_name(stamp_key))
					
			current_female_stamp_key = ""
			_female_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_female_stamp_color_control.set_disabled(false)
			
			_female_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()

func _on_FemaleStampColorButton_color_changed( color ):
	if(current_record):
		if(_female_stamp_color_control):
			if(current_female_stamp_key != ""):
				if(current_record.female_stamp_table.has(current_female_stamp_key) == true):
					current_record.female_stamp_table[current_female_stamp_key] = color
					
					current_database.mark_database_as_modified()
					
func _on_BipedTree_item_edited():
	if(current_record):
		var item = _biped_control.get_root().get_children()
		var i = 0
		var biped_flags = 0
		while(1):
			if(item.is_checked(0)):
				biped_flags |= 1 << i
			i += 1
			item = item.get_next()
			if(item == null):
				break
		current_record.biped_flags = biped_flags