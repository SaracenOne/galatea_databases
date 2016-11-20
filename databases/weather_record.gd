extends "generic_record.gd"
		
enum {CLASSIFICATION_NONE, 
 CLASSIFICATION_RAINING,
 CLASSIFICATION_SNOWING,
 CLASSIFICATION_FINE,
 CLASSIFICATION_CLOUDY}

enum {TIME_SUNRISE,
 TIME_DAY,
 TIME_SUNSET,
 TIME_NIGHT}

class CloudLayer extends Reference:
	var cloud_path = ""
	var scroll_x = 0.0
	var scroll_y = 0.0
	var alpha = 1.0
	
	func load_object(p_dictionary_object):
		if(p_dictionary_object.has("cloud_path")):
			cloud_path = p_dictionary_object.cloud_path
		if(p_dictionary_object.has("scroll_x")):
			scroll_x = p_dictionary_object.scroll_x
		if(p_dictionary_object.has("scroll_y")):
			scroll_y = p_dictionary_object.scroll_y
		if(p_dictionary_object.has("alpha")):
			alpha = p_dictionary_object.alpha
			
	func save_object():
		var dictionary = {}
		dictionary.cloud_path = cloud_path
		dictionary.scroll_x = scroll_x
		dictionary.scroll_y = scroll_y
		dictionary.alpha = alpha
		
		return dictionary

class ColorSet extends Reference:
	var ambient_color = Color()
	var clouds_color = Color()
	var begin_fog_color = Color()
	var end_fog_color = Color()
	var sky_color = Color()
	var sun_color = Color()
	var light_color = Color()
	
	func load_object(p_dictionary_object):
		if(p_dictionary_object.has("ambient_color")):
			ambient_color = Color(p_dictionary_object.ambient_color)
		if(p_dictionary_object.has("clouds_color")):
			clouds_color = Color(p_dictionary_object.clouds_color)
		if(p_dictionary_object.has("begin_fog_color")):
			begin_fog_color = Color(p_dictionary_object.begin_fog_color)
		if(p_dictionary_object.has("end_fog_color")):
			end_fog_color = Color(p_dictionary_object.end_fog_color)
		if(p_dictionary_object.has("sky_color")):
			sky_color = Color(p_dictionary_object.sky_color)
		if(p_dictionary_object.has("sun_color")):
			sun_color = Color(p_dictionary_object.sun_color)
		if(p_dictionary_object.has("light_color")):
			light_color = Color(p_dictionary_object.light_color)
			
	func save_object():
		var dictionary = {}
		dictionary.ambient_color = ambient_color.to_html()
		dictionary.clouds_color = clouds_color.to_html()
		dictionary.begin_fog_color = begin_fog_color.to_html()
		dictionary.end_fog_color = end_fog_color.to_html()
		dictionary.sky_color = sky_color.to_html()
		dictionary.sun_color = sun_color.to_html()
		dictionary.light_color = light_color.to_html()
		
		return dictionary

var wind_power = 0.0
var wind_direction = 0.0
var wind_variation = 0.0
var min_temperature = 14.0 # Celsius
var max_temperature = 14.0 # Celsius
var precipitation = null
var weather_classification = CLASSIFICATION_NONE
var color_sets = {TIME_SUNRISE:ColorSet.new(), TIME_DAY:ColorSet.new(), TIME_SUNSET:ColorSet.new(), TIME_NIGHT:ColorSet.new()}
var cloud_layers = [CloudLayer.new(), CloudLayer.new(), CloudLayer.new()]

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)

	if(p_dictionary_record.has("wind_power")):
		wind_power = p_dictionary_record.wind_power
	if(p_dictionary_record.has("wind_direction")):
		wind_direction = p_dictionary_record.wind_direction
	if(p_dictionary_record.has("wind_variation")):
		wind_variation = p_dictionary_record.wind_variation
		
	if(p_dictionary_record.has("min_temperature")):
		min_temperature = p_dictionary_record.min_temperature
	if(p_dictionary_record.has("max_temperature")):
		max_temperature = p_dictionary_record.max_temperature
		
	if(p_dictionary_record.has("precipitation")):
		var new_precipitation = p_databases.precipitation_database.find_record_by_name(p_dictionary_record.precipitation)
		if(new_precipitation != null):
			precipitation = new_precipitation
		
	if(p_dictionary_record.has("weather_classification")):
		if(p_dictionary_record.weather_classification == "none"):
			weather_classification = CLASSIFICATION_NONE
		elif(p_dictionary_record.weather_classification == "raining"):
			weather_classification = CLASSIFICATION_RAINING
		elif(p_dictionary_record.weather_classification == "snowing"):
			weather_classification = CLASSIFICATION_SNOWING
		elif(p_dictionary_record.weather_classification == "fine"):
			weather_classification = CLASSIFICATION_FINE
		elif(p_dictionary_record.weather_classification == "cloudy"):
			weather_classification = CLASSIFICATION_CLOUDY
		
	# Color sets
	if(p_dictionary_record.has("color_set_sunrise")):
		var color_set = ColorSet.new()
		color_set.load_object(p_dictionary_record.color_set_sunrise)
		color_sets[TIME_SUNRISE] = color_set
	if(p_dictionary_record.has("color_set_day")):
		var color_set = ColorSet.new()
		color_set.load_object(p_dictionary_record.color_set_day)
		color_sets[TIME_DAY] = color_set
	if(p_dictionary_record.has("color_set_sunset")):
		var color_set = ColorSet.new()
		color_set.load_object(p_dictionary_record.color_set_sunset)
		color_sets[TIME_SUNSET] = color_set
	if(p_dictionary_record.has("color_set_night")):
		var color_set = ColorSet.new()
		color_set.load_object(p_dictionary_record.color_set_night)
		color_sets[TIME_NIGHT] = color_set
		
	# Cloud Layers
	cloud_layers = []
	if(p_dictionary_record.has("cloud_layers")):
		for dictionary_cloud_layer in p_dictionary_record.cloud_layers:
			var cloud_layer = CloudLayer.new()
			cloud_layer.load_object(dictionary_cloud_layer)
			cloud_layers.append(cloud_layer)


func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)

	p_dictionary_record.wind_power = wind_power
	p_dictionary_record.wind_direction = wind_direction
	p_dictionary_record.wind_variation = wind_variation
	
	p_dictionary_record.min_temperature = min_temperature
	p_dictionary_record.max_temperature = max_temperature
	
	if(precipitation):
		p_dictionary_record.precipitation = precipitation.id
	else:
		p_dictionary_record.precipitation = ""
	
	if(weather_classification == CLASSIFICATION_NONE):
		p_dictionary_record.weather_classification = "none"
	elif(weather_classification == CLASSIFICATION_RAINING):
		p_dictionary_record.weather_classification = "raining"
	elif(weather_classification == CLASSIFICATION_SNOWING):
		p_dictionary_record.weather_classification = "snowing"
	elif(weather_classification == CLASSIFICATION_FINE):
		p_dictionary_record.weather_classification = "fine"
	elif(weather_classification == CLASSIFICATION_CLOUDY):
		p_dictionary_record.weather_classification = "cloudy"

	p_dictionary_record.color_set_sunrise = color_sets[TIME_SUNRISE].save_object()
	p_dictionary_record.color_set_day = color_sets[TIME_DAY].save_object()
	p_dictionary_record.color_set_sunset = color_sets[TIME_SUNSET].save_object()
	p_dictionary_record.color_set_night = color_sets[TIME_NIGHT].save_object()
	
	p_dictionary_record.cloud_layers = []
	for database_cloud_layer in cloud_layers:
		var cloud_layer_dictionary = database_cloud_layer.save_object()
		p_dictionary_record.cloud_layers.append(cloud_layer_dictionary)