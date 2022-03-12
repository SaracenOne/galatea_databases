class_name Gender

enum {
	GENDER_MALE,
	GENDER_FEMALE,
	GENDER_OTHER,
	GENDER_COUNT
}

static func get_gender_from_string(p_string):
	var lower_string = p_string.to_lower()
	
	if(lower_string == "male"):
		return GENDER_MALE
	elif(lower_string == "female"):
		return GENDER_FEMALE
	elif(lower_string) == "other":
		return GENDER_OTHER
	else:
		return -1
		
static func get_string_from_gender(p_gender):
	if(p_gender == GENDER_MALE):
		return "male"
	elif(p_gender == GENDER_FEMALE):
		return "female"
	elif(p_gender == GENDER_OTHER):
		return "other"
	else:
		""

static func get_cased_string_from_gender(p_gender):
	if(p_gender == GENDER_MALE):
		return "Male"
	elif(p_gender == GENDER_FEMALE):
		return "Female"
	elif(p_gender == GENDER_OTHER):
		return "Other"
	else:
		""
