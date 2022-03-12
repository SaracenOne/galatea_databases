@tool
extends "./generic_record.gd"

class WeatherData extends Resource:
	@export var priority: int = 50

@export var weather_data: Dictionary = {}
@export var weather_list: Array = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
