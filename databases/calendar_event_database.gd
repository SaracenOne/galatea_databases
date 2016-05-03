const generic_database_const = preload("generic_database.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

class CalendarEventDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_NAME = "calendar_event_database.json"
	const RECORDS_NAME = "calendar_event_records"

	class CalendarEventRecord:
		extends "generic_database.gd".GenericRecord
		var printed_name = ""
		var calendar_icon_path = ""
		
		var start_date_day = 1
		var start_date_month = date_and_time_const.MONTH_JANUARY
		
		var end_date_day = 1
		var end_date_month = date_and_time_const.MONTH_JANUARY
		
		var is_school_holiday = false
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return CalendarEventRecord.new()
		
	func _init(p_databases).(p_databases):
		pass