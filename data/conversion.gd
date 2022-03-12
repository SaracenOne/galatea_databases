static func convert_string_to_vector_2(p_str):
	if(p_str):
		var floats = p_str.substr(1, p_str.length()-1).split_floats(",")
		if(floats.size() == 2):
			return Vector2(floats[0], floats[1])
	
	return Vector2(0.0, 0.0)
	
static func convert_string_to_vector_3(p_str):
	if(p_str):
		var floats = p_str.substr(1, p_str.length()-1).split_floats(",")
		if(floats.size() == 3):
			return Vector3(floats[0], floats[1], floats[2])
	
	return Vector3(0.0, 0.0, 0.0)
	
static func convert_string_to_color(p_str):
	if(p_str):
		var floats = p_str.substr(0, p_str.length()).split_floats(",")
		if(floats.size() == 4):
			return Color(floats[0], floats[1], floats[2], floats[3])
	
	return Color(1.0, 1.0, 1.0, 1.0)
