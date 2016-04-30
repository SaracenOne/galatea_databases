tool
extends "database_panel.gd"

#
var database_records = null

var printed_name_control = null
var description_control = null
var icon_file_control = null
var visible_in_character_creator = null
var contradictory_traits_control = null

func _ready():
	printed_name_control = get_node("RightSide/PrintedNameContainer/PrintedNameControl")
	assert(printed_name_control)
	
	description_control = get_node("RightSide/DescriptionContainer/DescriptionControl")
	assert(description_control)
	
	icon_file_control = get_node("RightSide/IconFileMainContainer")
	assert(icon_file_control)
	
	visible_in_character_creator = get_node("RightSide/VisibleInCharacterCreatorContainer/VisibleInCharacterCreatorControl")
	assert(visible_in_character_creator)
	
func galatea_databases_assigned():
	database_records = get_node("LeftSide/DatabaseRecords")
	assert(database_records)
	
	contradictory_traits_control = get_node("RightSide/ContradictoryTraitsContainer/ContradictoryTraitsControl")
	assert(contradictory_traits_control)
	
	if not(is_connected("new_record_duplicate", database_records, "new_record_duplicate_callback")):
		connect("new_record_duplicate", database_records, "new_record_duplicate_callback")
		
	if not(is_connected("new_record_add_successful", database_records, "new_record_add_successful_callback")):
		connect("new_record_add_successful", database_records, "new_record_add_successful_callback")
		
	if not(is_connected("rename_record_successful", database_records, "rename_record_successful_callback")):
		connect("rename_record_successful", database_records, "rename_record_successful_callback")
		
	if not(is_connected("erase_record_successful", database_records, "erase_record_successful_callback")):
		connect("erase_record_successful", database_records, "erase_record_successful_callback")
	
	current_database = galatea_databases.trait_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		contradictory_traits_control.assign_database(current_database)
	else:
		printerr("location_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	printed_name_control.set_text(p_record.printed_name)
	printed_name_control.set_editable(true)
	
	description_control.set_wrap(true)
	description_control.set_text(p_record.description)
	
	icon_file_control.set_file_path(p_record.main_icon_path)
	icon_file_control.set_disabled(false)
	
	visible_in_character_creator.set_pressed(p_record.visible_in_character_creator)
	visible_in_character_creator.set_disabled(false)
	
	contradictory_traits_control.populate_tree(p_record.contradictory_traits, null)
	contradictory_traits_control.set_disabled(false)
	
func _on_printed_name_text_changed( p_printed_name ):
	if(current_record):
		current_record.printed_name = p_printed_name
		current_database.mark_database_as_modified()
		
func _on_DescriptionControl_text_changed():
	if(current_record):
		current_record.description = description_control.get_text()
		current_database.mark_database_as_modified()
		
func _on_IconFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.main_icon_path = p_path
		current_database.mark_database_as_modified()

func _on_VisibleInCharacterControl_toggled( pressed ):
	if(current_record):
		current_record.visible_in_character_creator = pressed
		current_database.mark_database_as_modified()

func _on_ContradictoryTraitsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.contradictory_traits.find(p_record) != -1):
			return
		else:
			current_record.contradictory_traits.append(p_record)
			contradictory_traits_control.populate_tree(current_record.contradictory_traits, null)
			current_database.mark_database_as_modified()

func _on_ContradictoryTraitsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.contradictory_traits.find(p_record) != -1):
			current_record.contradictory_traits.erase(p_record)
			contradictory_traits_control.populate_tree(current_record.contradictory_traits, null)
			current_database.mark_database_as_modified()