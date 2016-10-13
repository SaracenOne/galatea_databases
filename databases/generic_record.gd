extends Resource

const MAX_ID_SIZE = 32
var id = ""

func get_raw_id():
	var raw_id = id.to_ascii()
	raw_id.resize(MAX_ID_SIZE)
	return raw_id
		
func _load_record(p_dictionary_record, p_database_record):
	if(p_dictionary_record.has("metadata")):
		for meta in p_dictionary_record.metadata.keys():
			set_meta(meta, p_dictionary_record[meta])
	
func _save_record(p_dictionary_record, p_databases):
	p_dictionary_record.id = id
	p_dictionary_record.metadata = {}
	
	for meta in get_meta_list():
		p_dictionary_record.metadata[meta] = get_meta(meta)