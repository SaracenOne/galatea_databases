class_name BloodType

enum {
	BLOODTYPE_A,
	BLOODTYPE_B,
	BLOODTYPE_AB,
	BLOODTYPE_O,
	BLOODTYPE_COUNT
}

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
		return "🅰️"
	elif(p_bloodtype == BLOODTYPE_B):
		return "🅱️"
	elif(p_bloodtype == BLOODTYPE_AB):
		return "🆎"
	elif(p_bloodtype == BLOODTYPE_O):
		return "🅾️"
	else:
		""
