extends "generic_record.gd"

class WeatherData extends Resource:
	export(int) var priority = 50

export(Dictionary) var weather_data = {}
export(Array) var weather_list = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)