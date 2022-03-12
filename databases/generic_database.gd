@tool
extends RefCounted

var databases: RefCounted = null
var cached_dictionary: Dictionary = {}
var database_records: Dictionary = {}
var database_is_modified: bool = false

#const DATABASE_NAME = "generic_database"

func load_database_ids():
	pass
	
func load_database_values():
	pass
	
func _load_database_values(p_database_path, p_records_name):
	if(typeof(cached_dictionary) == TYPE_DICTIONARY):
		var dictionary_records = get_dictionary_records_array(cached_dictionary, p_database_path, p_records_name)
		if(typeof(dictionary_records) == TYPE_ARRAY):
			for i in range(0, dictionary_records.size()):
				var dictionary_record = dictionary_records[i]
				var database_record = database_records[dictionary_record.id]
				
				# Read Data
				database_record._load_record(dictionary_record, databases)
					
			cached_dictionary = {}
			return OK
		else:
			cached_dictionary = {}
			return FAILED
	else:
		return FAILED
	
func _save_database(p_filepath, p_records_name):
	# Construct and inlined script needed
	build_procedural_script()
	
	var dictionary = {}
	var database_dictionary_array = []
	
	var database_record_values = database_records.values()
	for database_record in database_record_values:
		var dictionary_record = {}
		
		database_record._save_record(dictionary_record, databases)
		
		database_dictionary_array.push_back(dictionary_record)
	
	dictionary[p_records_name] = database_dictionary_array
	ProjectSettings.set("cache/force_recache", true)
	ProjectSettings.save()
	_save_database_file(p_filepath, dictionary)

func load_database_file(p_filepath, p_records_name) -> Dictionary:
	var file = File.new()
	
	var file_error = file.open(p_filepath, File.READ)#
	
	if(!file_error == OK):
		file_error = file.open(p_filepath, File.WRITE)
		
		if(!file_error == OK):
			printerr("load_database_file(%s) failed to open file: error_code: %s" % [p_filepath, str(file_error)])
			return {}
		else:
			var new_dictionary = {}
			new_dictionary[p_records_name] = []
			
			var json: RefCounted = JSON.new()
			var json_string = json.stringify(new_dictionary, "\t")
			
			file.store_string(json_string)
			
			return new_dictionary
		
	file.seek(0)
	
	var file_buffer_string = file.get_as_text()
	file.close()
	
	if(file_buffer_string.length() == 0):
		printerr("load_database_file(%s) failed file buffer string length == 0", p_filepath)
		return {}
		
	var json: JSON = JSON.new()
	var err: int = json.parse(file_buffer_string)
	if err == OK:
		var dictionary = json.get_data()
		
		if(typeof(dictionary) == TYPE_DICTIONARY):
			return dictionary
		else:
			printerr("load_database_file(%s) failed to parse json", p_filepath)
			return {}
	else:
		printerr("load_database_file(%s) failed to parse json", p_filepath)
		return {}
		
func _save_database_file(p_filepath, p_dictionary) -> int:
	var file = File.new()
	
	var file_error = file.open(p_filepath, File.WRITE)
	
	if(!file_error == OK):
		printerr("save_database_file(%s) failed to open file: error_code: %u", p_filepath, file_error)
		return FAILED
		
	file.seek(0)
	
	var json: RefCounted = JSON.new()
	var json_string = json.stringify(p_dictionary, "\t")
	file.store_string(json_string)
	
	file.close()
	
	return OK
	
func get_dictionary_records_array(p_dictionary, p_database_path, p_records_name):
	if(typeof(p_dictionary) == TYPE_DICTIONARY):
		if(p_dictionary.keys().size() == 1):
			if(p_dictionary.keys()[0] == p_records_name):
				var dictionary_records = p_dictionary[p_dictionary.keys()[0]]
				return dictionary_records
			else:
				printerr("Database " + p_records_name + " does not have valid records name!")
				return null
		else:
			printerr("Database " + p_records_name + " does not have valid number of record databases!")
			return null
	else:
		printerr("Database " + p_records_name + " could not load database!")
		return null
	
func _load_database_ids(p_database_path, p_records_name):
	cached_dictionary = load_database_file(p_database_path, p_records_name)
	if !cached_dictionary.is_empty():
		var dictionary_records = get_dictionary_records_array(cached_dictionary, p_database_path, p_records_name)
		if(typeof(dictionary_records) == TYPE_ARRAY):
			for i in range(0, dictionary_records.size()):
				var new_record = call("_create_record")
				assert(new_record)
				
				if(dictionary_records[i].has("id")):
					new_record.id = dictionary_records[i].id
				else:
					printerr("Database " + p_records_name + " entry " + i + " does not have id!")
					return FAILED
					
				_insert_record(new_record)
			return OK
		else:
			return FAILED
		
func mark_database_as_modified(p_database_name: String):
	print("Database " + p_database_name + " marked as modified...")
	database_is_modified = true
		
func check_database_modified():
	return database_is_modified
		
func _init(p_databases):
	databases = p_databases

func find_record_by_name(p_id):
	if(database_records.has(p_id)):
		return database_records[p_id]
	
	return null

func _insert_record(p_record):
	database_records[p_record.id] = p_record
	databases.global_records_list[p_record.id] = p_record

func create_new_record(p_id: String):
	if(!p_id.is_empty()):
		if(!databases.global_records_list.has(p_id)):
			var new_record = call("_create_record")
			new_record.id = p_id
			
			_insert_record(new_record)
			
			return new_record
		else:
			return null
	else:
		return null
		
func rename_record(p_from: String, p_to: String):
	if(!p_from.is_empty() and !p_to.is_empty()):
		if(database_records.has(p_from) and databases.global_records_list.has(p_from)):
			var record = database_records[p_from]
			record.id = p_to
			erase_record(p_from)
			
			_insert_record(record)
			return record
	return null
	
func erase_record(p_name: String) -> void:
	if(!p_name.is_empty()):
		database_records.erase(p_name)
		databases.global_records_list.erase(p_name)
				
func build_procedural_script():
	var script_text = ""
	
	for database_record in database_records.values():
		if(has_method("get_record_inlined_code")):
			var dictionary = call("get_record_inlined_code", database_record)
			if(dictionary != null):
				for key in dictionary.keys():
					script_text += "func " + call("get_database_name") + "_" + database_record.id + "_" + key + "():\n"
					
					var code_raw = dictionary[key]
					if(code_raw != null and code_raw.length() > 0):
						var code = code_raw.split("\n", -1)
					
						for line in code:
							script_text += "\t" + line + "\n"
					else:
						script_text += "\tpass\n"
						
					script_text += "\n"
	
	var inline_directory = Directory.new()
	if(inline_directory.open("res://assets/scripts") == OK):
		if(inline_directory.dir_exists("res://assets/scripts/inline") == false):
			if(inline_directory.make_dir("res://assets/scripts/inline") != OK):
				printerr("Could not create inline directory ):")
				return null
			
	var f = File.new()
	f.open("res://assets/scripts/inline/" + call("get_inlined_filename"), File.WRITE)
	f.store_string(script_text)
	f.close()
