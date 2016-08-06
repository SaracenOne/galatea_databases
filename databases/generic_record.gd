extends Resource

const MAX_ID_SIZE = 32
var id = ""

func get_raw_id():
	var raw_id = id.to_ascii()
	raw_id.resize(MAX_ID_SIZE)
	return raw_id
	
static func load_color_dictionary(p_color_dictionary):
	var color = Color()
	
	if(p_color_dictionary.has("r")):
		color.x = p_color_dictionary.x
	if(p_color_dictionary.has("g")):
		color.y = p_color_dictionary.y
	if(p_color_dictionary.has("b")):
		color.z = p_color_dictionary.z
		
	return color
		
static func save_color_dictionary(p_color):
	var color_dictionary = Dictionary()
	
	color_dictionary.x = p_color.x
	color_dictionary.y = p_color.y
	color_dictionary.z = p_color.z
		
	return color_dictionary

static func load_vector_3_dictionary(p_vector3_dictionary):
	var vector3 = Vector3()
	
	if(p_vector3_dictionary.has("x")):
		vector3.x = p_vector3_dictionary.x
	if(p_vector3_dictionary.has("y")):
		vector3.y = p_vector3_dictionary.y
	if(p_vector3_dictionary.has("z")):
		vector3.z = p_vector3_dictionary.z
		
	return vector3
		
static func save_vector_3_dictionary(p_vector3):
	var vector3_dictionary = Dictionary()
	
	vector3_dictionary.x = p_vector3.x
	vector3_dictionary.y = p_vector3.y
	vector3_dictionary.z = p_vector3.z
		
	return vector3_dictionary

static func load_vector_2_dictionary(p_vector2_dictionary):
	var vector2 = Vector2()
	
	if(p_vector2_dictionary.has("x")):
		vector2.x = p_vector2_dictionary.x
	if(p_vector2_dictionary.has("y")):
		vector2.y = p_vector2_dictionary.y
		
	return vector2
		
static func save_vector_2_dictionary(p_vector2):
	var vector2_dictionary = Dictionary()
	
	vector2_dictionary.x = p_vector2.x
	vector2_dictionary.y = p_vector2.y
		
	return vector2_dictionary
	
func _load_record(p_dictionary_record, p_databases):
	if(p_dictionary_record.has("metadata")):
		for meta in p_dictionary_record.metadata.keys():
			set_meta(meta, p_dictionary_record[meta])
	
func _save_record(p_dictionary_record):
	p_dictionary_record.id = id
	p_dictionary_record.metadata = {}
	
	for meta in get_meta_list():
		p_dictionary_record.metadata[meta] = get_meta(meta)