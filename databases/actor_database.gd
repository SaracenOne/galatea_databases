const generic_database_const = preload("generic_database.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
#
class ActorDatabase:
	extends "generic_database.gd".GenericDatabase
	const GENDER_MALE = 0
	const GENDER_FEMALE = 1
	
	const BLOODTYPE_A = 0
	const BLOODTYPE_B = 1
	const BLOODTYPE_AB = 2
	const BLOODTYPE_O = 3
	
	const DATABASE_IDENT = "ACTR"
	const DATABASE_NAME = "actor_database"
	const DATABASE_NAME_JSON = "actor_database.json"
	const DATABASE_NAME_BINARY = "actor_database.gbd"
	const DATABASE_INLINED_FILENAME = "actor_database_inlined.gd"
	const RECORDS_NAME = "actor_records"
	
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
	
	class ActorRecord:
		extends "generic_database.gd".GenericRecord
		
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
		
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("family_name")):
			p_database_record.family_name = p_dictionary_record.family_name
		if(p_dictionary_record.has("given_name")):
			p_database_record.given_name = p_dictionary_record.given_name
		if(p_dictionary_record.has("nickname")):
			p_database_record.nickname = p_dictionary_record.nickname
		
		if(p_dictionary_record.has("gender")):
			p_database_record.gender = get_gender_from_string(p_dictionary_record.gender)
		if(p_dictionary_record.has("age")):
			p_database_record.age = p_dictionary_record.age
		if(p_dictionary_record.has("bloodtype")):
			p_database_record.bloodtype = get_bloodtype_from_string(p_dictionary_record.bloodtype)
		if(p_dictionary_record.has("date_of_birth_day")):
			p_database_record.date_of_birth_day = p_dictionary_record.date_of_birth_day
		if(p_dictionary_record.has("date_of_birth_month")):
			p_database_record.date_of_birth_month = date_and_time_const.get_month_from_string(p_dictionary_record.date_of_birth_month)
		
		# Flags
		if(p_dictionary_record.has("is_valid_contact")):
			p_database_record.is_valid_contact = p_dictionary_record.is_valid_contact
		if(p_dictionary_record.has("is_storyline_actor")):
			p_database_record.is_storyline_actor = p_dictionary_record.is_storyline_actor
			
		if(p_dictionary_record.has("contact_icon_path")):
			p_database_record.contact_icon_path = p_dictionary_record.contact_icon_path
		
		if(p_dictionary_record.has("actor_groups")):
			for actor_group_name in p_dictionary_record.actor_groups:
				var actor_group = databases.actor_group_database.find_record_by_name(actor_group_name)
				if(actor_group != null):
					p_database_record.actor_groups.append(actor_group)
					
		if(p_dictionary_record.has("traits")):
			for trait_name in p_dictionary_record.traits:
				var trait = databases.trait_database.find_record_by_name(trait_name)
				if(trait != null):
					p_database_record.traits.append(trait)
					
		if(p_dictionary_record.has("ai_packages")):
			for ai_package_name in p_dictionary_record.ai_packages:
				var ai_package = databases.ai_package_database.find_record_by_name(ai_package_name)
				if(ai_package != null):
					p_database_record.ai_packages.append(ai_package)
		
		if(p_dictionary_record.has("stats")):
			p_database_record.stats = p_dictionary_record.stats
			
		if(p_dictionary_record.has("hair")):
			p_database_record.hair = p_dictionary_record.hair
		if(p_dictionary_record.has("height")):
			p_database_record.height = p_dictionary_record.height
		if(p_dictionary_record.has("scalers")):
			p_database_record.scalers = p_dictionary_record.scalers
		if(p_dictionary_record.has("facial_deformations")):
			p_database_record.facial_deformations = p_dictionary_record.facial_deformations
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.family_name = p_database_record.family_name
		p_dictionary_record.given_name = p_database_record.given_name
		p_dictionary_record.nickname = p_database_record.nickname
		
		p_dictionary_record.gender = get_string_from_gender(p_database_record.gender)
		p_dictionary_record.age = p_database_record.age
		p_dictionary_record.bloodtype = get_string_from_bloodtype(p_database_record.bloodtype)
		
		p_dictionary_record.date_of_birth_day = p_database_record.date_of_birth_day
		p_dictionary_record.date_of_birth_month = date_and_time_const.get_string_from_month(p_database_record.date_of_birth_month)
		
		# Flags
		p_dictionary_record.is_valid_contact = p_database_record.is_valid_contact
		p_dictionary_record.is_storyline_actor = p_database_record.is_storyline_actor
		
		###
		p_dictionary_record.contact_icon_path = p_database_record.contact_icon_path
		
		p_dictionary_record.actor_groups = []
		for actor_group in p_database_record.actor_groups:
			p_dictionary_record.actor_groups.append(actor_group.id)
			
		p_dictionary_record.traits = []
		for trait in p_database_record.traits:
			p_dictionary_record.traits.append(trait.id)
			
		p_dictionary_record.ai_packages = []
		for ai_package in p_database_record.ai_packages:
			p_dictionary_record.ai_packages.append(ai_package.id)
		
		p_dictionary_record.stats = p_database_record.stats
		
		p_dictionary_record.hair = p_database_record.hair
		p_dictionary_record.height = p_database_record.height
		p_dictionary_record.scalers = p_database_record.scalers
		p_dictionary_record.facial_deformations = p_database_record.facial_deformations
		
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return ActorRecord.new()
		
	func get_record_inlined_code(p_database_record):
		var dict = {}
		dict["test1"] = ""
		return dict
		
	func _init(p_databases).(p_databases):
		pass