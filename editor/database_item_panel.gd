tool
extends "database_panel.gd"

#
var database_records = null

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var description_control = NodePath()
export(NodePath) var value_control = NodePath()
export(NodePath) var item_type_control = NodePath()
export(NodePath) var icon_file_control = NodePath()
export(NodePath) var pickup_sfx_control = NodePath()
export(NodePath) var putdown_sfx_control = NodePath()
export(NodePath) var can_gift_control = NodePath()

var printed_name_control_node = null
var description_control_node = null
var value_control_node = null
var item_type_control_node = null
var icon_file_control_node = null
var pickup_sfx_control_node = null
var putdown_sfx_control_node = null
var can_gift_control_node = null

func _ready():
	printed_name_control_node = get_node(printed_name_control)
	assert(printed_name_control_node)
	
	description_control_node = get_node(description_control)
	assert(description_control_node)
	
	value_control_node = get_node(value_control)
	assert(value_control_node)
	
	item_type_control_node = get_node(item_type_control)
	assert(item_type_control_node)
	
	icon_file_control_node = get_node(icon_file_control)
	assert(icon_file_control_node)
	
	pickup_sfx_control_node = get_node(pickup_sfx_control)
	assert(pickup_sfx_control_node)
	
	putdown_sfx_control_node = get_node(putdown_sfx_control)
	assert(putdown_sfx_control_node)
	
	can_gift_control_node = get_node(can_gift_control)
	assert(can_gift_control_node)

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
	
	current_database = galatea_databases.item_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("item_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	printed_name_control_node.set_text(current_record.printed_name)
	printed_name_control_node.set_editable(true)
	
	description_control_node.set_text(current_record.description)
	
	value_control_node.set_value(current_record.value)
	value_control_node.set_editable(true)
	
	item_type_control_node.select(current_record.item_type)
	item_type_control_node.set_disabled(false)
	
	icon_file_control_node.set_file_path(current_record.icon_path)
	icon_file_control_node.set_disabled(false)
	
	pickup_sfx_control_node.set_file_path(current_record.pickup_sfx)
	pickup_sfx_control_node.set_disabled(false)
	
	putdown_sfx_control_node.set_file_path(current_record.putdown_sfx)
	putdown_sfx_control_node.set_disabled(false)
	
	can_gift_control_node.set_pressed(current_record.can_gift)
	can_gift_control_node.set_disabled(false)

func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()

func _on_DescriptionTextEdit_text_changed():
	if(current_record):
		current_record.description = description_control_node.get_text()
		current_database.mark_database_as_modified()

func _on_ValueSpinBox_value_changed( value ):
	if(current_record):
		current_record.value = value
		current_database.mark_database_as_modified()

func _on_ItemTypeOptionButton_item_selected( ID ):
	if(current_record):
		current_record.item_type = ID
		current_database.mark_database_as_modified()

func _on_IconFilePathControl_file_selected( p_path ):
	if(current_record):
		current_record.icon_path = p_path
		current_database.mark_database_as_modified()

func _on_PickupSFXPathControl_file_selected( p_path ):
	if(current_record):
		current_record.pickup_sfx = p_path
		current_database.mark_database_as_modified()

func _on_PutdownSFXPathControl_file_selected( p_path ):
	if(current_record):
		current_record.putdown_sfx = p_path
		current_database.mark_database_as_modified()

func _on_CanGiftCheckBox_toggled( pressed ):
	if(current_record):
		current_record.can_gift = pressed
		current_database.mark_database_as_modified()
