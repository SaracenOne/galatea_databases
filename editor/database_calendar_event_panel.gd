tool
extends "database_panel.gd"

#
var database_records = null

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var calendar_icon_path_control = NodePath()
export(NodePath) var calendar_icon_preview_control = NodePath()
export(NodePath) var date_start_control = NodePath()
export(NodePath) var date_end_control = NodePath()
export(NodePath) var is_school_holiday_control = NodePath()
export(NodePath) var is_hidden_control = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _calendar_icon_path_control_node = get_node(calendar_icon_path_control)
onready var _calendar_icon_preview_control_node = get_node(calendar_icon_preview_control)
onready var _date_start_control_node = get_node(date_start_control)
onready var _date_end_control_node = get_node(date_end_control)
onready var _is_school_holiday_control_node = get_node(is_school_holiday_control)
onready var _is_hidden_control_node = get_node(is_hidden_control)

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
	
	current_database = galatea_databases.calendar_event_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("calendar_event_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_calendar_icon_path_control_node.set_file_path(current_record.calendar_icon_path)
	_calendar_icon_path_control_node.set_disabled(false)
	
	_calendar_icon_preview_control_node.set_texture(null)
	var calendar_icon_texture = load(p_record.calendar_icon_path)
	if(calendar_icon_texture):
		if(calendar_icon_texture extends Texture):
			_calendar_icon_preview_control_node.set_texture(calendar_icon_texture)
			
	_date_start_control_node.set_disabled(false)
	_date_start_control_node.set_day(p_record.start_date_day)
	_date_start_control_node.set_month(p_record.start_date_month - 1)
	
	_date_end_control_node.set_disabled(false)
	_date_end_control_node.set_day(p_record.end_date_day)
	_date_end_control_node.set_month(p_record.end_date_month - 1)
	
	_is_school_holiday_control_node.set_disabled(false)
	_is_school_holiday_control_node.set_pressed(p_record.is_school_holiday)
	
	_is_hidden_control_node.set_disabled(false)
	_is_hidden_control_node.set_pressed(p_record.is_hidden)


func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()

func _on_CalendarIconFilePath_file_selected( p_path ):
	if(current_record):
		current_record.calendar_icon_path = p_path
		
		_calendar_icon_preview_control_node.set_texture(null)
		var calendar_icon_texture = load(p_path)
		if(calendar_icon_texture):
			if(calendar_icon_texture extends Texture):
				_calendar_icon_preview_control_node.set_texture(calendar_icon_texture)
			
		current_database.mark_database_as_modified()
		
func _on_StartDateOption_day_changed( p_day ):
	if(current_record):
		current_record.start_date_day = p_day
		current_database.mark_database_as_modified()
		
func _on_StartDateOption_month_changed( p_month ):
	if(current_record):
		current_record.start_date_month = p_month + 1
		current_database.mark_database_as_modified()
		
func _on_EndDateOption_day_changed( p_day ):
	if(current_record):
		current_record.end_date_day = p_day
		current_database.mark_database_as_modified()
		
func _on_EndDateOption_month_changed( p_month ):
	if(current_record):
		print(p_month)
		current_record.end_date_month = p_month + 1
		current_database.mark_database_as_modified()
		
func _on_IsSchoolHolidayCheckBox_toggled( pressed ):
	if(current_record):
		current_record.is_school_holiday = pressed
		current_database.mark_database_as_modified()
		
func _on_IsHiddenCheckBox_toggled( pressed ):
	if(current_record):
		current_record.is_hidden = pressed
		current_database.mark_database_as_modified()
