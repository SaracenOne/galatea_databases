const generic_database_const = preload("generic_database.gd")
const conditionals_const = preload("../conditionals/conditionals.gd")

class MusicTrackDatabase:
	extends "generic_database.gd".GenericDatabase

	const DATABASE_IDENT = "MUTK"
	const DATABASE_NAME = "music_track_database"
	const DATABASE_NAME_JSON = "music_track_database.json"
	const DATABASE_NAME_BINARY = "music_track_database.gbd"
	const DATABASE_INLINED_FILENAME = "music_track_database_inlined.gd"
	const RECORDS_NAME = "music_track_records"
	
	const TRACK_TYPE_SINGLE_TRACK = 0
	const TRACK_TYPE_ASYNC_TRACK = 1
	
	static func get_track_type_from_string(p_string):
		var upper_string = p_string.to_upper()
		
		if(upper_string == "SINGLE_TRACK"):
			return TRACK_TYPE_SINGLE_TRACK
		elif(upper_string == "ASYNC_TRACK"):
			return TRACK_TYPE_ASYNC_TRACK
		else:
			return -1
			
	static func get_string_from_track_type(p_track_type):
		if(p_track_type == TRACK_TYPE_SINGLE_TRACK):
			return "SINGLE_TRACK"
		elif(p_track_type == TRACK_TYPE_ASYNC_TRACK):
			return "ASYNC_TRACK"
		else:
			""
	
	class MusicTrackRecord:
		extends "generic_database.gd".GenericRecord
		
		var track_title = ""
		var track_artist = ""
		var track_type = TRACK_TYPE_SINGLE_TRACK
		var contains_loop = false
		var loop_start = 0.0
		var track_path = ""
		var playable_on_music_player = false
		var conditionals = conditionals_const.new()
				
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("track_title")):
			p_database_record.track_title = p_dictionary_record.track_title
		if(p_dictionary_record.has("track_artist")):
			p_database_record.track_artist = p_dictionary_record.track_artist
		if(p_dictionary_record.has("track_path")):
			p_database_record.track_path = p_dictionary_record.track_path
		if(p_dictionary_record.has("contains_loop")):
			p_database_record.contains_loop = p_dictionary_record.contains_loop
		if(p_dictionary_record.has("loop_start")):
			p_database_record.loop_start = p_dictionary_record.loop_start
		if(p_dictionary_record.has("playable_on_music_player")):
			p_database_record.playable_on_music_player = p_dictionary_record.playable_on_music_player
		if(p_dictionary_record.has("conditionals")):
			conditionals_const.load_from_dictionary(p_database_record.conditionals, p_dictionary_record.conditionals)
		
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.track_title = p_database_record.track_title
		p_dictionary_record.track_artist = p_database_record.track_artist
		p_dictionary_record.track_path = p_database_record.track_path
		p_dictionary_record.contains_loop = p_database_record.contains_loop
		p_dictionary_record.loop_start = p_database_record.loop_start
		p_dictionary_record.playable_on_music_player = p_database_record.playable_on_music_player
		p_dictionary_record.conditionals = conditionals_const.save_to_dictionary(p_database_record.conditionals)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return MusicTrackRecord.new()
		
	func _init(p_databases).(p_databases):
		pass