@tool
extends Control

var blood_type_option: OptionButton = null
@export var disabled: bool = false: set = set_disabled

signal blood_type_changed(p_blood_type)

func set_disabled(p_disabled):
	disabled = p_disabled
	if(blood_type_option):
		blood_type_option.set_disabled(p_disabled)
		
func blood_type_value_changed(p_blood_type):
	emit_signal("blood_type_changed", p_blood_type)

func _ready():
	blood_type_option = get_node("BloodTypeControl")
	assert(blood_type_option)
	
	blood_type_option.clear()
	for i in range(BloodType.BLOODTYPE_A, BloodType.BLOODTYPE_COUNT):
		blood_type_option.add_item(BloodType.get_string_from_bloodtype(i))
	
	assert(blood_type_option.connect("item_selected", Callable(self, "blood_type_value_changed")) == OK)
	
	set_disabled(disabled)
	
func set_blood_type(p_value):
	if(!blood_type_option):
		blood_type_option = get_node("BloodTypeControl")
	blood_type_option.select(p_value)
