extends "generic_record.gd"

class WeatherData extends Reference:
	var priority = 50

var weather_data = {}
var weather_list = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)