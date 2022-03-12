@tool
extends Control

var gender_option: OptionButton = null
@export var disabled: bool = false: set = set_disabled

signal gender_changed(p_gender)

func set_disabled(p_disabled):
	disabled = p_disabled
	if(gender_option):
		gender_option.set_disabled(p_disabled)
		
func gender_value_changed(p_gender):
	emit_signal("gender_changed", p_gender)

func _ready():
	gender_option = get_node("GenderOptionButton")
	assert(gender_option)
	
	gender_option.clear()
	for i in range(Gender.GENDER_MALE, Gender.GENDER_COUNT):
		gender_option.add_item(Gender.get_cased_string_from_gender(i))
	
	assert(gender_option.connect("item_selected", Callable(self, "gender_value_changed")) == OK)
	
	set_disabled(disabled)
	
func set_gender(p_value):
	if(!gender_option):
		gender_option = get_node("GenderOptionButton")
	gender_option.select(p_value)
