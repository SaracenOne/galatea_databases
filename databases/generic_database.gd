class GenericRecord extends Reference:
	const MAX_ID_SIZE = 32
	var id = ""
	
	func get_raw_id():
		var raw_id = id.to_ascii()
		raw_id.resize(MAX_ID_SIZE)
		return raw_id

class GenericDatabase extends Reference:
	var databases = null
	var cached_dictionary = null
	var database_records = []
	var database_is_modified = false
	
	func load_database_ids():
		pass
		
	func load_database_values():
		pass
		
	func _load_record(p_dictionary_record, p_database_record):
		if(p_dictionary_record.has("metadata")):
			for meta in p_dictionary_record.metadata.keys():
				p_database_record.set_meta(meta, p_dictionary_record[meta])
		
	func _load_database_values(p_database_path, p_records_name):
		if(cached_dictionary != null):
			var dictionary_records = get_dictionary_records_array(cached_dictionary, p_database_path, p_records_name)
			if(dictionary_records != null):
				for i in range(0, dictionary_records.size()):
					var database_record = database_records[i]
					var dictionary_record = dictionary_records[i]
					
					# Read Data
					_load_record(dictionary_record, database_record)
						
				cached_dictionary = null
				return OK
			else:
				cached_dictionary = null
				return FAILED
		else:
			return FAILED
		
	func _save_record(p_database_record, p_dictionary_record):
		p_dictionary_record.id = p_database_record.id
		p_dictionary_record.metadata = {}
		
		for meta in p_database_record.get_meta_list():
			p_dictionary_record.metadata[meta] = p_database_record.get_meta(meta)
		
	func _save_database(p_filepath, p_records_name):
		var dictionary = {}
		
		var database_dictionary_array = []
		
		for database_record in database_records:
			var dictionary_record = {}
			
			_save_record(database_record, dictionary_record)
			
			database_dictionary_array.push_back(dictionary_record)
		
		dictionary[p_records_name] = database_dictionary_array
		_save_database_file(p_filepath, dictionary)

	func load_database_file(p_filepath, p_records_name):
		var file = File.new()
		
		var file_error = file.open(p_filepath, File.READ)#
		
		if(!file_error == OK):
			
			file_error = file.open(p_filepath, File.WRITE)
			
			if(!file_error == OK):
				printerr("load_database_file(%s) failed to open file: error_code: %u", p_filepath, file_error)
				return null
			else:
				var new_dictionary = {}
				new_dictionary[p_records_name] = []
				var json_string = new_dictionary.to_json()
				
				file.store_string(json_string)
				
				return new_dictionary
			
		file.seek(0)
		
		var file_buffer_string = file.get_as_text()
		file.close()
		
		if(file_buffer_string.length() == 0):
			printerr("load_database_file(%s) failed file buffer string length == 0", p_filepath)
			return null
			
		var dictionary = Dictionary()
		var json_error = dictionary.parse_json(file_buffer_string)
		
		if(json_error == OK):
			return dictionary
		else:
			printerr("load_database_file(%s) failed to parse json: error_code: %u", p_filepath, json_error)
			return null
			
	func _save_database_file(p_filepath, p_dictionary):
		var file = File.new()
		
		var file_error = file.open(p_filepath, File.WRITE)
		
		if(!file_error == OK):
			printerr("save_database_file(%s) failed to open file: error_code: %u", p_filepath, file_error)
			return FAILED
			
		file.seek(0)
		
		var json_string = p_dictionary.to_json()
		file.store_string(json_string)
		
		file.close()
		
		return OK
		
	func get_dictionary_records_array(p_dictionary, p_database_path, p_records_name):
		if(p_dictionary != null):
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
		var dictionary_records = get_dictionary_records_array(cached_dictionary, p_database_path, p_records_name)
		if(dictionary_records != null):
			for i in range(0, dictionary_records.size()):
			
				var new_record = _create_record()
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
			
	func mark_database_as_modified():
		database_is_modified=true
			
	func check_database_modified():
		return database_is_modified
			
	func _init(p_databases):
		databases = p_databases
	
	static func load_color_dictionary(p_color_dictionary):
		var color = Color()
		
		if(p_color_dictionary.has("r")):
			color.x = p_color_dictionary.x
		if(p_color_dictionary.has("g")):
			color.y = p_color_dictionary.y
		if(p_color_dictionary.has("b")):
			color.z = p_color_dictionary.z
			
		return color
			
	static func save_color_dictionary(p_color):
		var color_dictionary = Dictionary()
		
		color_dictionary.x = p_color.x
		color_dictionary.y = p_color.y
		color_dictionary.z = p_color.z
			
		return color_dictionary
	
	static func load_vector_3_dictionary(p_vector3_dictionary):
		var vector3 = Vector3()
		
		if(p_vector3_dictionary.has("x")):
			vector3.x = p_vector3_dictionary.x
		if(p_vector3_dictionary.has("y")):
			vector3.y = p_vector3_dictionary.y
		if(p_vector3_dictionary.has("z")):
			vector3.z = p_vector3_dictionary.z
			
		return vector3
			
	static func save_vector_3_dictionary(p_vector3):
		var vector3_dictionary = Dictionary()
		
		vector3_dictionary.x = p_vector3.x
		vector3_dictionary.y = p_vector3.y
		vector3_dictionary.z = p_vector3.z
			
		return vector3_dictionary
	
	static func load_vector_2_dictionary(p_vector2_dictionary):
		var vector2 = Vector2()
		
		if(p_vector2_dictionary.has("x")):
			vector2.x = p_vector2_dictionary.x
		if(p_vector2_dictionary.has("y")):
			vector2.y = p_vector2_dictionary.y
			
		return vector2
			
	static func save_vector_2_dictionary(p_vector2):
		var vector2_dictionary = Dictionary()
		
		vector2_dictionary.x = p_vector2.x
		vector2_dictionary.y = p_vector2.y
			
		return vector2_dictionary
	
	func find_record_by_name(p_id):
		for i in range(0, database_records.size()):
			if(database_records[i].id == p_id):
				return database_records[i]
		
		return null
	
	func _insert_record(p_record):
		for i in range(0, database_records.size()):
			if(p_record.id.casecmp_to(database_records[i].id) < 0):
				database_records.insert(i, p_record)
				return
			
		database_records.push_back(p_record)
	
	func create_new_record(p_id):
		if(!p_id.empty()):
			
			var new_record = _create_record()
			new_record.id = p_id
			
			_insert_record(new_record)
			
			return new_record
		else:
			return null
			
	func rename_record(p_from, p_to):
		if(!p_from.empty() and !p_to.empty()):
			var record = find_record_by_name(p_from)
			if(record != null):
				database_records.remove(database_records.find(record))
				
				record.id = p_to
				
				_insert_record(record)
				return record
		return null
		
	func erase_record(p_name):
		if(!p_name.empty()):
			for record in database_records:
				if(p_name == record.id):
					database_records.remove(database_records.find(record))