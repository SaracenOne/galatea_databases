extends "generic_record.gd"
	
const ITEM_TYPE_UNKNOWN = 0
const ITEM_TYPE_MISC = 1
const ITEM_TYPE_KEY = 2
const ITEM_TYPE_CONSUMABLE = 3

var printed_name = ""
var description = ""
var value = 0
var item_type = ITEM_TYPE_UNKNOWN
var icon_path = ""
var pickup_sfx = ""
var putdown_sfx = ""
var can_gift = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("description")):
		description = p_dictionary_record.description
		
	if(p_dictionary_record.has("value")):
		value = p_dictionary_record.value
	
	if(p_dictionary_record.has("item_type")):
		if(p_dictionary_record.item_type == "misc"):
			item_type = ITEM_TYPE_MISC
		elif(p_dictionary_record.item_type == "key"):
			item_type = ITEM_TYPE_KEY
		elif(p_dictionary_record.item_type == "consumable"):
			item_type = ITEM_TYPE_CONSUMABLE
		else:
			item_type = ITEM_TYPE_UNKNOWN
	
	if(p_dictionary_record.has("icon_path")):
		icon_path = p_dictionary_record.icon_path
	
	if(p_dictionary_record.has("pickup_sfx")):
		pickup_sfx = p_dictionary_record.pickup_sfx
		
	if(p_dictionary_record.has("putdown_sfx")):
		putdown_sfx = p_dictionary_record.putdown_sfx
		
	if(p_dictionary_record.has("can_gift")):
		can_gift = p_dictionary_record.can_gift
		
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.description = description
	p_dictionary_record.value = value
	
	if(item_type == ITEM_TYPE_MISC):
		p_dictionary_record.item_type = "misc"
	elif(item_type == ITEM_TYPE_KEY):
		p_dictionary_record.item_type = "key"
	elif(item_type == ITEM_TYPE_CONSUMABLE):
		p_dictionary_record.item_type = "consumable"
	else:
		p_dictionary_record.item_type = "???"
	
	p_dictionary_record.icon_path = icon_path
	p_dictionary_record.pickup_sfx = pickup_sfx
	p_dictionary_record.putdown_sfx = putdown_sfx
	p_dictionary_record.can_gift = can_gift