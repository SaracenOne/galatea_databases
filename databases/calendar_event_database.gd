const generic_database_const = preload("generic_database.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

class CalendarEventDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "CALE"
	const DATABASE_NAME = "calendar_event_database.json"
	const DATABASE_NAME_BINARY = "calendar_event_database.gbd"
	const RECORDS_NAME = "calendar_event_records"
	
	class CalendarEventRecord:
		extends "generic_database.gd".GenericRecord
		var printed_name = ""
		var calendar_icon_path = ""
		
		var start_date_day = 1
		var start_date_month = OS.MONTH_JANUARY
		
		var end_date_day = 1
		var end_date_month = OS.MONTH_JANUARY
		
		var is_school_holiday = false
		var is_hidden = false
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("printed_name")):
			p_database_record.printed_name = p_dictionary_record.printed_name
		if(p_dictionary_record.has("calendar_icon_path")):
			p_database_record.calendar_icon_path = p_dictionary_record.calendar_icon_path
		
		if(p_dictionary_record.has("start_date_day")):
			p_database_record.start_date_day = p_dictionary_record.start_date_day
		if(p_dictionary_record.has("start_date_month")):
			p_database_record.start_date_month = date_and_time_const.get_month_from_string(p_dictionary_record.start_date_month)
		if(p_dictionary_record.has("end_date_day")):
			p_database_record.end_date_day = p_dictionary_record.end_date_day
		if(p_dictionary_record.has("end_date_month")):
			p_database_record.end_date_month = date_and_time_const.get_month_from_string(p_dictionary_record.end_date_month)
		
		# Flags
		if(p_dictionary_record.has("is_school_holiday")):
			p_database_record.is_school_holiday = p_dictionary_record.is_school_holiday
		if(p_dictionary_record.has("is_hidden")):
			p_database_record.is_hidden = p_dictionary_record.is_hidden
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.calendar_icon_path = p_database_record.calendar_icon_path
		
		p_dictionary_record.start_date_day = p_database_record.start_date_day
		p_dictionary_record.start_date_month = date_and_time_const.get_string_from_month(p_database_record.start_date_month)
		p_dictionary_record.end_date_day = p_database_record.end_date_day
		p_dictionary_record.end_date_month = date_and_time_const.get_string_from_month(p_database_record.end_date_month)
		
		#Flags
		p_dictionary_record.is_school_holiday = p_database_record.is_school_holiday
		p_dictionary_record.is_hidden = p_database_record.is_hidden
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return CalendarEventRecord.new()
		
	func _init(p_databases).(p_databases):
		pass