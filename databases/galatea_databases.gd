
const activity_database_const = preload("activity_database.gd")
const ai_package_database_const = preload("ai_package_database.gd")
const actor_database_const = preload("actor_database.gd")
const actor_group_database_const = preload("actor_group_database.gd")
const body_scaler_database_const = preload("body_scaler_database.gd")
const calendar_event_database_const = preload("calendar_event_database.gd")
const hair_database_const = preload("hair_database.gd")
const item_database_const = preload("item_database.gd")
const clothing_set_database_const = preload("clothing_set_database.gd")
const location_database_const = preload("location_database.gd")
const material_type_database_const = preload("material_type_database.gd")
const music_track_database_const = preload("music_track_database.gd")
const quest_database_const = preload("quest_database.gd")
const readable_database_const = preload("readable_database.gd")
const status_effect_database_const = preload("status_effect_database.gd")
const trait_database_const = preload("trait_database.gd")
const weather_database_const = preload("weather_database.gd")
	
var activity_database = null
var ai_package_database = null
var actor_database = null
var actor_group_database = null
var body_scaler_database = null
var calendar_event_database = null
var hair_database = null
var item_database = null
var clothing_set_database = null
var location_database = null
var material_type_database = null
var music_track_database = null
var quest_database = null
var readable_database = null
var status_effect_database = null
var trait_database = null
var weather_database = null

var path = "res://assets/databases"

var database_list = []
var database_dirty_list = []
	
func load_all_databases():
	var status = OK

	init_databases()

	for current_database in database_list:
		assert(current_database)
		add_to_dirty_list(current_database)
		
	load_dirty_list()
	
func add_to_dirty_list(p_database):
	if(database_dirty_list.find(p_database) == -1):
		database_dirty_list.push_back(p_database)
	
func load_dirty_list():
	for current_database in database_dirty_list:
		assert(current_database)
		current_database.load_database_ids()
		
	for current_database in database_dirty_list:
		assert(current_database)
		current_database.load_database_values()
		
func save_all_databases():
	for database in database_list:
		if(database.check_database_modified()):
			database.save_database()
	
func init_databases():
	database_list = []
	database_dirty_list = []
		
	activity_database = activity_database_const.ActivityDatabase.new(self)
	assert(activity_database)#
	database_list.push_back(activity_database)

	ai_package_database = ai_package_database_const.AIPackageDatabase.new(self)
	assert(ai_package_database)
	database_list.push_back(ai_package_database)
	
	actor_database = actor_database_const.ActorDatabase.new(self)
	assert(actor_database)
	database_list.push_back(actor_database)
	
	actor_group_database = actor_group_database_const.ActorGroupDatabase.new(self)
	assert(actor_group_database)
	database_list.push_back(actor_group_database)
	
	body_scaler_database = body_scaler_database_const.BodyScalerDatabase.new(self)
	assert(body_scaler_database)
	database_list.push_back(body_scaler_database)
	
	calendar_event_database = calendar_event_database_const.CalendarEventDatabase.new(self)
	assert(calendar_event_database)
	database_list.push_back(calendar_event_database)
	
	hair_database = hair_database_const.HairDatabase.new(self)
	assert(hair_database)
	database_list.push_back(hair_database)
	
	item_database = item_database_const.ItemDatabase.new(self)
	assert(item_database)
	database_list.push_back(item_database)

	clothing_set_database = clothing_set_database_const.ClothingSetDatabase.new(self)
	assert(clothing_set_database)
	database_list.push_back(clothing_set_database)
	
	location_database = location_database_const.LocationDatabase.new(self)
	assert(location_database)
	database_list.push_back(location_database)
	
	material_type_database = material_type_database_const.MaterialTypeDatabase.new(self)
	assert(material_type_database)
	database_list.push_back(material_type_database)
	
	music_track_database = music_track_database_const.MusicTrackDatabase.new(self)
	assert(music_track_database)
	database_list.push_back(music_track_database)
	
	quest_database = quest_database_const.QuestDatabase.new(self)
	assert(quest_database)
	database_list.push_back(quest_database)
	
	readable_database = readable_database_const.ReadableDatabase.new(self)
	assert(readable_database)
	database_list.push_back(readable_database)
	
	status_effect_database = status_effect_database_const.StatusEffectDatabase.new(self)
	assert(status_effect_database)
	database_list.push_back(status_effect_database)
	
	trait_database = trait_database_const.TraitDatabase.new(self)
	assert(trait_database)
	database_list.push_back(trait_database)
	
	weather_database = weather_database_const.WeatherDatabase.new(self)
	assert(weather_database)
	database_list.push_back(weather_database)
	
func check_database_modified():
	var is_modified = false
	
	for current_database in database_list:
		if(current_database.check_database_modified()):
			is_modified = true
			
	return is_modified
	
func _init(p_path):
	path = p_path