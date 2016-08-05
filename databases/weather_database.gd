const generic_database_const = preload("generic_database.gd")

class WeatherDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "WEAT"
	const DATABASE_NAME = "weather_database"
	const DATABASE_NAME_JSON = "weather_database.json"
	const DATABASE_NAME_BINARY = "weather_database.gdb"
	const DATABASE_INLINED_FILENAME = "weather_database_inlined.gd"
	const RECORDS_NAME = "weather_set_records"

	const CLASSIFICATION_NONE = 0
	const CLASSIFICAITION_RAINING = 1
	const CLASSIFICAITION_SNOWING = 2
	const CLASSIFICAITION_FINE = 3
	const CLASSIFICAITION_CLOUDY = 4

	const TIME_SUNRISE = 0
	const TIME_DAY = 1
	const TIME_SUNSET = 2
	const TIME_NIGHT = 3

	class WeatherRecord:
		extends "generic_database.gd".GenericRecord
		
		class ColorSet:
			var ambient = Color()
			var clouds = Color()
			var begin_fog = Color()
			var end_fog = Color()
			var sky_color = Color()
			var sun_color = Color()
			
			func load_object(p_dictionary_object):
				if(p_dictionary_object.has("ambient")):
					ambient = p_dictionary_object.ambient
				if(p_dictionary_object.has("clouds")):
					clouds = p_dictionary_object.clouds
				if(p_dictionary_object.has("begin_fog")):
					begin_fog = p_dictionary_object.begin_fog
				if(p_dictionary_object.has("end_fog")):
					end_fog = p_dictionary_object.end_fog
				if(p_dictionary_object.has("sky_color")):
					sky_color = p_dictionary_object.sky_color
				if(p_dictionary_object.has("sun_color")):
					sun_color = p_dictionary_object.sun_color
					
			func save_object():
				var dictionary = {}
				dictionary.ambient = ambient
				dictionary.clouds = clouds
				dictionary.begin_fog = begin_fog
				dictionary.end_fog = end_fog
				dictionary.sky_color = sky_color
				dictionary.sun_color = sun_color
				
				return dictionary
				
			func _init(p_dictionary = null):
				if(p_dictionary):
					load_object(p_dictionary)
		
		var wind_intensity = 0.0
		var min_temperature = 14.0 # Celsius
		var max_temperature = 14.0 # Celsius
		var color_sets = {}
		
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("wind_intensity")):
			p_database_record.wind_intensity = p_dictionary_record.wind_intensity
		if(p_dictionary_record.has("min_temperature")):
			p_database_record.min_temperature = p_dictionary_record.min_temperature
		if(p_dictionary_record.has("max_temperature")):
			p_database_record.max_temperature = p_dictionary_record.max_temperature
		# Color sets
		if(p_dictionary_record.has("color_set_sunrise")):
			p_database_record.color_sets[TIME_SUNRISE] = WeatherRecord.ColorSet.new(p_dictionary_record.color_set_sunrise)
		if(p_dictionary_record.has("color_set_day")):
			p_database_record.color_sets[TIME_DAY] = WeatherRecord.ColorSet.new(p_dictionary_record.color_set_day)
		if(p_dictionary_record.has("color_set_sunset")):
			p_database_record.color_sets[TIME_SUNSET] = WeatherRecord.ColorSet.new(p_dictionary_record.color_set_sunset)
		if(p_dictionary_record.has("color_set_night")):
			p_database_record.color_sets[TIME_NIGHT] = WeatherRecord.ColorSet.new(p_dictionary_record.color_set_night)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.wind_intensity = p_database_record.wind_intensity
		p_dictionary_record.min_temperature = p_database_record.min_temperature
		p_dictionary_record.max_temperature = p_database_record.max_temperature
		
		p_dictionary_record.color_set_sunrise = p_database_record.color_sets[TIME_SUNRISE].save_object()
		p_dictionary_record.color_set_day = p_database_record.color_sets[TIME_DAY].save_object()
		p_dictionary_record.color_set_sunset = p_database_record.color_sets[TIME_SUNSET].save_object()
		p_dictionary_record.color_set_night = p_database_record.color_sets[TIME_NIGHT].save_object()
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return WeatherRecord.new()
		
	func _init(p_databases).(p_databases):
		pass