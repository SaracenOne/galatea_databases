const generic_database_const = preload("generic_database.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
#
const conditionals_const = preload("../conditionals/conditionals.gd")
const ai_procedure_tree_const = preload("../ai/ai_procedure_tree.gd")

class AIPackageDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "AIPK"
	const DATABASE_NAME = "ai_package_database.json"
	const DATABASE_NAME_BINARY = "ai_package_database.gbd"
	const RECORDS_NAME = "ai_package_records"
	
	class AIPackageRecord:
		extends "generic_database.gd".GenericRecord
		
		class Schedule:
			const DAY_FLAG_SUNDAY = 1
			const DAY_FLAG_MONDAY = 2
			const DAY_FLAG_TUESDAY = 4
			const DAY_FLAG_WEDNESDAY = 8
			const DAY_FLAG_THURSDAY = 16
			const DAY_FLAG_FRIDAY = 32
			const DAY_FLAG_SATURDAY = 64
			
			const DAY_FLAG_WEEKDAYS = 62
			const DAY_FLAG_WEEKENDS = 65
			
			var duration = 0.0
			
			var start_minutes = -1
			var start_hours = -1
			
			var days_in_week_flag = 0
			var days_flag = 0
			var months_flag = 0
			
		var conditionals = conditionals_const.new()
		var schedule = Schedule.new()
		
		
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
		return AIPackageRecord.new()
		
	func _init(p_databases).(p_databases):
		pass