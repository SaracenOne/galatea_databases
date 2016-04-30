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
	
	const DATABASE_NAME = "actor_database.json"
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
		
		var is_storyline_actor=false
		var is_unique=false
		
		var actor_groups = []
		var traits = []
		
		var stats = {}
		
		class Appearence:
			var hair = ""
			var scalers = {}
			var facial_deformations = {}
			
		var appearence = Appearence.new()
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_appearence(p_appearence, p_appearence_dictionary):
		if(p_appearence_dictionary.has("hair")):
			p_appearence.hair = p_appearence_dictionary.hair
		if(p_appearence_dictionary.has("scalers")):
			p_appearence.scalers = p_appearence_dictionary.scalers
		if(p_appearence_dictionary.has("facial_deformations")):
			p_appearence.facial_deformations = p_appearence_dictionary.facial_deformations
		
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
		
		if(p_dictionary_record.has("stats")):
			p_database_record.stats = p_dictionary_record.stats
			
		if(p_dictionary_record.has("appearence")):
			_load_appearence(p_database_record.appearence, p_dictionary_record.appearence)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
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
		
		p_dictionary_record.actor_groups = []
		for actor_group in p_database_record.actor_groups:
			p_dictionary_record.actor_groups.append(actor_group.id)
			
		p_dictionary_record.traits = []
		for trait in p_database_record.traits:
			p_dictionary_record.traits.append(trait.id)
		
		p_dictionary_record.stats = p_database_record.stats
		
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return ActorRecord.new()
		
	func _init(p_databases).(p_databases):
		pass