@tool
extends "./generic_record.gd"
class_name GalActorRecord

const conversion_const = preload("../data/conversion.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

@export var gender: int = Gender.GENDER_MALE

@export var age: int = 0
@export var bloodtype: int = BloodType.BLOODTYPE_A

@export var date_of_birth_day: int = 0
@export var date_of_birth_month: int = 0

@export var given_name: String = ""
@export var family_name: String = ""
@export var nickname: String = ""

@export var is_valid_contact: bool = false
@export var is_storyline_actor: bool = false

@export var contact_icon_path: String = ""

@export var actor_groups: Array = []
@export var traits: Array = []
@export var ai_packages: Array = []

@export var stats: Dictionary = {}

# Appearence
@export var head: Resource = null
@export var head_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var eyes: Resource = null
@export var eyes_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var eyebrows: Resource = null
@export var eyebrows_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var mouth: Resource = null
@export var mouth_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var eyelashes: Resource = null
@export var eyelashes_color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var skin_color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var hair: Resource = null
@export var hair_color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var body: Resource = null
@export var default_clothing_set: Resource = null

@export var height: float = 1.0
@export var body_scaler_table: Dictionary = {}
@export var head_morph_table: Dictionary = {}
@export var stamp_table: Dictionary = {}
		
func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("family_name")):
		family_name = p_dictionary_record.family_name
	if(p_dictionary_record.has("given_name")):
		given_name = p_dictionary_record.given_name
	if(p_dictionary_record.has("nickname")):
		nickname = p_dictionary_record.nickname
	
	if(p_dictionary_record.has("gender")):
		gender = Gender.get_gender_from_string(p_dictionary_record.gender)
	if(p_dictionary_record.has("age")):
		age = p_dictionary_record.age
	if(p_dictionary_record.has("bloodtype")):
		bloodtype = BloodType.get_bloodtype_from_string(p_dictionary_record.bloodtype)
	if(p_dictionary_record.has("date_of_birth_day")):
		date_of_birth_day = p_dictionary_record.date_of_birth_day
	if(p_dictionary_record.has("date_of_birth_month")):
		date_of_birth_month = date_and_time_const.get_month_from_string(p_dictionary_record.date_of_birth_month)
	
	# Flags
	if(p_dictionary_record.has("is_valid_contact")):
		is_valid_contact = p_dictionary_record.is_valid_contact
	if(p_dictionary_record.has("is_storyline_actor")):
		is_storyline_actor = p_dictionary_record.is_storyline_actor
		
	if(p_dictionary_record.has("contact_icon_path")):
		contact_icon_path = p_dictionary_record.contact_icon_path
	
	if(p_dictionary_record.has("actor_groups")):
		for actor_group_name in p_dictionary_record.actor_groups:
			var actor_group = p_databases.actor_group_database.find_record_by_name(actor_group_name)
			if(actor_group != null):
				actor_groups.append(actor_group)
				
	if(p_dictionary_record.has("traits")):
		for trait_name in p_dictionary_record.traits:
			var trait_record = p_databases.trait_database.find_record_by_name(trait_name)
			if(trait_record != null):
				traits.append(trait_record)
				
	if(p_dictionary_record.has("ai_packages")):
		for ai_package_name in p_dictionary_record.ai_packages:
			var ai_package_record = p_databases.ai_package_database.find_record_by_name(ai_package_name)
			if(ai_package_record != null):
				ai_packages.append(ai_package_record)
	
	if(p_dictionary_record.has("head")):
		head = p_databases.headpart_database.find_record_by_name(p_dictionary_record.head)
	else:
		head = null
	if(p_dictionary_record.has("head_color")):
		head_color = conversion_const.convert_string_to_color(p_dictionary_record.head_color)
	else:
		head_color = Color(1.0, 1.0, 1.0, 1.0)
		
	if(p_dictionary_record.has("eyes")):
		eyes = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyes)
	else:
		eyes = null
	if(p_dictionary_record.has("eyes_color")):
		eyes_color = conversion_const.convert_string_to_color(p_dictionary_record.eyes_color)
	else:
		eyes_color = Color(1.0, 1.0, 1.0, 1.0)
		
	if(p_dictionary_record.has("eyebrows")):
		eyebrows = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyebrows)
	else:
		eyebrows = null
	if(p_dictionary_record.has("eyebrows_color")):
		eyebrows_color = conversion_const.convert_string_to_color(p_dictionary_record.eyebrows_color)
	else:
		eyebrows_color = Color(1.0, 1.0, 1.0, 1.0)
		
	if(p_dictionary_record.has("mouth")):
		mouth = p_databases.headpart_database.find_record_by_name(p_dictionary_record.mouth)
	else:
		mouth = null
	if(p_dictionary_record.has("mouth_color")):
		mouth_color = conversion_const.convert_string_to_color(p_dictionary_record.mouth_color)
	else:
		mouth_color = Color(1.0, 1.0, 1.0, 1.0)
		
	if(p_dictionary_record.has("eyelashes")):
		eyelashes = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyelashes)
	else:
		eyelashes = null
	if(p_dictionary_record.has("eyelashes_color")):
		eyelashes_color = conversion_const.convert_string_to_color(p_dictionary_record.eyelashes_color)
	else:
		eyelashes_color = Color(1.0, 1.0, 1.0, 1.0)
		
	if(p_dictionary_record.has("stats")):
		stats = p_dictionary_record.stats
		
	if(p_dictionary_record.has("skin_color")):
		skin_color = conversion_const.convert_string_to_color(p_dictionary_record.skin_color)
		
	if(p_dictionary_record.has("hair")):
		hair = p_databases.hair_database.find_record_by_name(p_dictionary_record.hair)
		
	if(p_dictionary_record.has("hair_color")):
		hair_color = conversion_const.convert_string_to_color(p_dictionary_record.hair_color)
		
	if(p_dictionary_record.has("body")):
		body = p_databases.body_database.find_record_by_name(p_dictionary_record.body)
		
	if(p_dictionary_record.has("default_clothing_set")):
		default_clothing_set = p_databases.clothing_set_database.find_record_by_name(p_dictionary_record.default_clothing_set)
		
	if(p_dictionary_record.has("height")):
		height = p_dictionary_record.height
	if(p_dictionary_record.has("body_scaler_table")):
		body_scaler_table = p_dictionary_record.body_scaler_table
	if(p_dictionary_record.has("head_morph_table")):
		head_morph_table = p_dictionary_record.head_morph_table
		
	stamp_table = {}
	if(p_dictionary_record.has("stamp_table")):
		for stamp in p_dictionary_record.stamp_table.keys():
			var stamp_record = p_databases.stamp_database.find_record_by_name(stamp)
			stamp_table[stamp_record] = conversion_const.convert_string_to_color(p_dictionary_record.stamp_table[stamp])
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.family_name = family_name
	p_dictionary_record.given_name = given_name
	p_dictionary_record.nickname = nickname
	
	p_dictionary_record.gender = Gender.get_string_from_gender(gender)
	p_dictionary_record.age = age
	p_dictionary_record.bloodtype = BloodType.get_string_from_bloodtype(bloodtype)
	
	p_dictionary_record.date_of_birth_day = date_of_birth_day
	p_dictionary_record.date_of_birth_month = date_and_time_const.get_string_from_month(date_of_birth_month)
	
	# Flags
	p_dictionary_record.is_valid_contact = is_valid_contact
	p_dictionary_record.is_storyline_actor = is_storyline_actor
	
	###
	p_dictionary_record.contact_icon_path = contact_icon_path
	
	p_dictionary_record.actor_groups = []
	for actor_group in actor_groups:
		p_dictionary_record.actor_groups.append(actor_group.id)
		
	p_dictionary_record.traits = []
	for trait_record in traits:
		p_dictionary_record.traits.append(trait_record.id)
		
	p_dictionary_record.ai_packages = []
	for ai_package_record in ai_packages:
		p_dictionary_record.ai_packages.append(ai_package_record.id)
	
	p_dictionary_record.stats = stats
	
	if(head):
		p_dictionary_record.head = head.id
	else:
		p_dictionary_record.head = ""
	p_dictionary_record.head_color = head_color
		
	if(eyes):
		p_dictionary_record.eyes = eyes.id
	else:
		p_dictionary_record.eyes = ""
	p_dictionary_record.eyes_color = eyes_color
		
	if(eyebrows):
		p_dictionary_record.eyebrows = eyebrows.id
	else:
		p_dictionary_record.eyebrows = ""
	p_dictionary_record.eyebrows_color = eyebrows_color
		
	if(mouth):
		p_dictionary_record.mouth = mouth.id
	else:
		p_dictionary_record.mouth = ""
	p_dictionary_record.mouth_color = mouth_color
		
	if(eyelashes):
		p_dictionary_record.eyelashes = eyelashes.id
	else:
		p_dictionary_record.eyelashes = ""
	p_dictionary_record.eyelashes_color = eyelashes_color
		
	p_dictionary_record.skin_color = skin_color
	
	if(hair):
		p_dictionary_record.hair = hair.id
	else:
		p_dictionary_record.hair = ""
	
	p_dictionary_record.hair_color = hair_color
	
	if(body):
		p_dictionary_record.body = body.id
		
	if(default_clothing_set):
		p_dictionary_record.default_clothing_set = default_clothing_set.id
	
	p_dictionary_record.height = height
	p_dictionary_record.body_scaler_table = body_scaler_table
	p_dictionary_record.head_morph_table = head_morph_table
	p_dictionary_record.stamp_table = {}
	
	for stamp in stamp_table.keys():
		p_dictionary_record.stamp_table[stamp.id] = stamp_table[stamp]
		
func get_valid_blend_key_list():
	var blend_key_list = []
	var blend_key_paths = []

	if(head and head.meshpart and head.meshpart.gen_morph_path):
		blend_key_paths.append(head.meshpart.gen_morph_path)
	if(eyes and eyes.meshpart and eyes.meshpart.gen_morph_path):
		blend_key_paths.append(eyes.meshpart.gen_morph_path)
	if(eyebrows and eyebrows.meshpart and eyebrows.meshpart.gen_morph_path):
		blend_key_paths.append(eyebrows.meshpart.gen_morph_path)
	if(eyelashes and eyelashes.meshpart and eyelashes.meshpart.gen_morph_path):
		blend_key_paths.append(eyelashes.meshpart.gen_morph_path)

	for blend_key_path in blend_key_paths:
		var blend_data_collection = load(blend_key_path)
		if(blend_data_collection):
			for blend_data in blend_data_collection.blend_shape_data:
				if(!blend_key_list.has(blend_data.name)):
					blend_key_list.append(blend_data.name)

	return blend_key_list
