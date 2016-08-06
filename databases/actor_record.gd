extends "generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

const GENDER_MALE = 0
const GENDER_FEMALE = 1

const BLOODTYPE_A = 0
const BLOODTYPE_B = 1
const BLOODTYPE_AB = 2
const BLOODTYPE_O = 3

var gender = GENDER_MALE

var age = 0
var bloodtype = BLOODTYPE_A

var date_of_birth_day = 0
var date_of_birth_month = 0

var given_name= ""
var family_name = ""
var nickname = ""

var is_valid_contact=false
var is_storyline_actor=false

var contact_icon_path = ""

var actor_groups = []
var traits = []
var ai_packages = []

var stats = {}

# Appearence
var hair = ""
var height = 1.0
var scalers = {}
var facial_deformations = {}

static func get_bloodtype_from_string(p_string):
	var upper_string = p_string.to_upper()
	
	if(upper_string == "A"):
		return BLOODTYPE_A
	elif(upper_string == "B"):
		return BLOODTYPE_B
	elif(upper_string == "AB"):
		return BLOODTYPE_AB
	elif(upper_string == "O"):
		return BLOODTYPE_O
	else:
		return -1
		
static func get_string_from_bloodtype(p_bloodtype):
	if(p_bloodtype == BLOODTYPE_A):
		return "A"
	elif(p_bloodtype == BLOODTYPE_B):
		return "B"
	elif(p_bloodtype == BLOODTYPE_AB):
		return "AB"
	elif(p_bloodtype == BLOODTYPE_O):
		return "O"
	else:
		""
		
static func get_emoji_from_bloodtype(p_bloodtype):
	if(p_bloodtype == BLOODTYPE_A):
		return " "
	elif(p_bloodtype == BLOODTYPE_B):
		return " "
	elif(p_bloodtype == BLOODTYPE_AB):
		return " "
	elif(p_bloodtype == BLOODTYPE_O):
		return " ️"
	else:
		""
		
static func get_gender_from_string(p_string):
	var lower_string = p_string.to_lower()
	
	if(lower_string == "male"):
		return GENDER_MALE
	elif(lower_string == "female"):
		return GENDER_FEMALE
	else:
		return -1
		
static func get_string_from_gender(p_gender):
	if(p_gender == GENDER_MALE):
		return "male"
	elif(p_gender == GENDER_FEMALE):
		return "female"
	else:
		""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("family_name")):
		family_name = p_dictionary_record.family_name
	if(p_dictionary_record.has("given_name")):
		given_name = p_dictionary_record.given_name
	if(p_dictionary_record.has("nickname")):
		nickname = p_dictionary_record.nickname
	
	if(p_dictionary_record.has("gender")):
		gender = get_gender_from_string(p_dictionary_record.gender)
	if(p_dictionary_record.has("age")):
		age = p_dictionary_record.age
	if(p_dictionary_record.has("bloodtype")):
		bloodtype = get_bloodtype_from_string(p_dictionary_record.bloodtype)
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
			var trait = p_databases.trait_database.find_record_by_name(trait_name)
			if(trait != null):
				traits.append(trait)
				
	if(p_dictionary_record.has("ai_packages")):
		for ai_package_name in p_dictionary_record.ai_packages:
			var ai_package = p_databases.ai_package_database.find_record_by_name(ai_package_name)
			if(ai_package != null):
				ai_packages.append(ai_package)
	
	if(p_dictionary_record.has("stats")):
		stats = p_dictionary_record.stats
		
	if(p_dictionary_record.has("hair")):
		hair = p_dictionary_record.hair
	if(p_dictionary_record.has("height")):
		height = p_dictionary_record.height
	if(p_dictionary_record.has("scalers")):
		scalers = p_dictionary_record.scalers
	if(p_dictionary_record.has("facial_deformations")):
		facial_deformations = p_dictionary_record.facial_deformations
		
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)
	
	p_dictionary_record.family_name = family_name
	p_dictionary_record.given_name = given_name
	p_dictionary_record.nickname = nickname
	
	p_dictionary_record.gender = get_string_from_gender(gender)
	p_dictionary_record.age = age
	p_dictionary_record.bloodtype = get_string_from_bloodtype(bloodtype)
	
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
	for trait in traits:
		p_dictionary_record.traits.append(trait.id)
		
	p_dictionary_record.ai_packages = []
	for ai_package in ai_packages:
		p_dictionary_record.ai_packages.append(ai_package.id)
	
	p_dictionary_record.stats = stats
	
	p_dictionary_record.hair = hair
	p_dictionary_record.height = height
	p_dictionary_record.scalers = scalers
	p_dictionary_record.facial_deformations = facial_deformations