@tool
const activity_database_const = preload("activity_database.gd")
const ai_package_database_const = preload("ai_package_database.gd")
const actor_database_const = preload("actor_database.gd")
const actor_group_database_const = preload("actor_group_database.gd")
const body_database_const = preload("body_database.gd")
const body_scaler_database_const = preload("body_scaler_database.gd")
const calendar_event_database_const = preload("calendar_event_database.gd")
const clothing_database_const = preload("clothing_database.gd")
const clothing_part_database_const = preload("clothing_part_database.gd")
const clothing_set_database_const = preload("clothing_set_database.gd")
const event_database_const = preload("event_database.gd")
const global_svar_database_const = preload("global_svar_database.gd")
const hair_database_const = preload("hair_database.gd")
const headpart_database_const = preload("headpart_database.gd")
const item_database_const = preload("item_database.gd")
const location_database_const = preload("location_database.gd")
const material_type_database_const = preload("material_type_database.gd")
const meshpart_database_const = preload("meshpart_database.gd")
const music_track_database_const = preload("music_track_database.gd")
const precipitation_database_const = preload("precipitation_database.gd")
const quest_database_const = preload("quest_database.gd")
const school_lesson_database_const = preload("school_lesson_database.gd")
const sms_database_const = preload("sms_database.gd")
const stamp_database_const = preload("stamp_database.gd")
const status_effect_database_const = preload("status_effect_database.gd")
const texture_set_database_const = preload("texture_set_database.gd")
const trait_database_const = preload("trait_database.gd")
const weather_database_const = preload("weather_database.gd")
	
var activity_database = null
var ai_package_database = null
var actor_database = null
var actor_group_database = null
var body_database = null
var body_scaler_database = null
var calendar_event_database = null
var clothing_database = null
var clothing_part_database = null
var clothing_set_database = null
var event_database = null
var global_svar_database = null
var hair_database = null
var headpart_database = null
var item_database = null
var location_database = null
var material_type_database = null
var meshpart_database = null
var music_track_database = null
var precipitation_database = null
var quest_database = null
var school_lesson_database = null
var sms_database = null
var stamp_database = null
var status_effect_database = null
var texture_set_database = null
var trait_database = null
var weather_database = null

var path = "res://assets/databases"

var global_records_list = {}

#stat IDS
const STAT_STRESS = 0
const STAT_CREATIVITY = 1
const STAT_LOGIC = 2
const STAT_KNOWLEDGE = 3
const STAT_FITNESS = 4
const STAT_CHARM = 5
const STAT_SENSITIVITY = 6
const STAT_STAMINA = 7
const STAT_LUCK = 8
const STAT_REPUTATION = 9
const STAT_MONEY = 10

var database_list = {}
var database_dirty_list = []
	
func load_all_databases():
	var status = OK

	init_databases()

	for current_database in database_list.values():
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
	for database in database_list.values():
		if(database.check_database_modified()):
			print(database.DATABASE_NAME + " saved...")
			database.save_database()
	
func init_databases():
	database_list = {}
	database_dirty_list = []
		
	activity_database = activity_database_const.new(self)
	assert(activity_database)#
	database_list[activity_database_const.DATABASE_NAME] = activity_database

	ai_package_database = ai_package_database_const.new(self)
	assert(ai_package_database)
	database_list[ai_package_database_const.DATABASE_NAME] = ai_package_database
	
	actor_database = actor_database_const.new(self)
	assert(actor_database)
	database_list[actor_database_const.DATABASE_NAME] = actor_database
	
	actor_group_database = actor_group_database_const.new(self)
	assert(actor_group_database)
	database_list[actor_group_database_const.DATABASE_NAME] = actor_group_database
	
	body_database = body_database_const.new(self)
	assert(body_database)
	database_list[body_database_const.DATABASE_NAME] = body_database
	
	body_scaler_database = body_scaler_database_const.new(self)
	assert(body_scaler_database)
	database_list[body_scaler_database_const.DATABASE_NAME] = body_scaler_database
	
	calendar_event_database = calendar_event_database_const.new(self)
	assert(calendar_event_database)
	database_list[calendar_event_database_const.DATABASE_NAME] = calendar_event_database
	
	clothing_database = clothing_database_const.new(self)
	assert(clothing_database)
	database_list[clothing_database_const.DATABASE_NAME] = clothing_database
	
	clothing_part_database = clothing_part_database_const.new(self)
	assert(clothing_part_database)
	database_list[clothing_part_database_const.DATABASE_NAME] = clothing_part_database
	
	clothing_set_database = clothing_set_database_const.new(self)
	assert(clothing_set_database)
	database_list[clothing_set_database_const.DATABASE_NAME] = clothing_set_database
	
	event_database = event_database_const.new(self)
	assert(event_database)
	database_list[event_database_const.DATABASE_NAME] = event_database
	
	global_svar_database = global_svar_database_const.new(self)
	assert(global_svar_database)
	database_list[global_svar_database_const.DATABASE_NAME] = global_svar_database
	
	hair_database = hair_database_const.new(self)
	assert(hair_database)
	database_list[hair_database_const.DATABASE_NAME] = hair_database
	
	headpart_database = headpart_database_const.new(self)
	assert(headpart_database)
	database_list[headpart_database_const.DATABASE_NAME] = headpart_database
	
	item_database = item_database_const.new(self)
	assert(item_database)
	database_list[item_database_const.DATABASE_NAME] = item_database
	
	location_database = location_database_const.new(self)
	assert(location_database)
	database_list[location_database_const.DATABASE_NAME] = location_database
	
	material_type_database = material_type_database_const.new(self)
	assert(material_type_database)
	database_list[material_type_database_const.DATABASE_NAME] = material_type_database
	
	meshpart_database = meshpart_database_const.new(self)
	assert(meshpart_database)
	database_list[meshpart_database_const.DATABASE_NAME] = meshpart_database
	
	music_track_database = music_track_database_const.new(self)
	assert(music_track_database)
	database_list[music_track_database_const.DATABASE_NAME] = music_track_database
	
	precipitation_database = precipitation_database_const.new(self)
	assert(precipitation_database)
	database_list[precipitation_database_const.DATABASE_NAME] = precipitation_database
	
	quest_database = quest_database_const.new(self)
	assert(quest_database)
	database_list[quest_database_const.DATABASE_NAME] = quest_database
	
	school_lesson_database = school_lesson_database_const.new(self)
	assert(school_lesson_database)
	database_list[school_lesson_database_const.DATABASE_NAME] = school_lesson_database
	
	sms_database = sms_database_const.new(self)
	assert(sms_database)
	database_list[sms_database_const.DATABASE_NAME] = sms_database
	
	stamp_database = stamp_database_const.new(self)
	assert(stamp_database)
	database_list[stamp_database_const.DATABASE_NAME] = stamp_database
	
	status_effect_database = status_effect_database_const.new(self)
	assert(status_effect_database)
	database_list[status_effect_database_const.DATABASE_NAME] = status_effect_database
	
	texture_set_database = texture_set_database_const.new(self)
	assert(texture_set_database)
	database_list[texture_set_database_const.DATABASE_NAME] = texture_set_database
	
	trait_database = trait_database_const.new(self)
	assert(trait_database)
	database_list[trait_database_const.DATABASE_NAME] = trait_database
	
	weather_database = weather_database_const.new(self)
	assert(weather_database)
	database_list[weather_database_const.DATABASE_NAME] = weather_database
	
func check_database_modified():
	var is_modified = false
	
	for current_database in database_list.values():
		if(current_database.check_database_modified()):
			is_modified = true
			
	return is_modified
	
func find_record_by_name(p_name):
	if(global_records_list.has(p_name)):
		return global_records_list[p_name]
	
func _init(p_path):
	path = p_path
