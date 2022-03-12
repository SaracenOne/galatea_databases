@tool
extends "./generic_record.gd"
	
enum {ITEM_TYPE_UNKNOWN,
 ITEM_TYPE_MISC,
 ITEM_TYPE_KEY,
 ITEM_TYPE_CONSUMABLE}

@export var printed_name: String = ""
@export var description: String = ""
@export var value: int = 0
@export var item_type: int = ITEM_TYPE_UNKNOWN
@export var icon_path: String = ""
@export var pickup_sfx: String = ""
@export var putdown_sfx: String = ""
@export var can_gift: bool = false
@export var invisible_in_inventory: bool = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
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
		
	if(p_dictionary_record.has("invisible_in_inventory")):
		invisible_in_inventory = p_dictionary_record.invisible_in_inventory
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
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
	p_dictionary_record.invisible_in_inventory = invisible_in_inventory
