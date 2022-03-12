@tool
extends Control

var day_option: SpinBox = null
var month_option: OptionButton = null
@export var disabled: bool = false: set = set_disabled

signal day_changed(p_day)
signal month_changed(p_month)

func set_disabled(p_disabled):
	disabled = p_disabled
	if(day_option):
		day_option.set_editable(!p_disabled)
		if(p_disabled):
			day_option.set_step(0)
		else:
			day_option.set_step(1)
	if(month_option):
		month_option.set_disabled(p_disabled)
		
func day_value_changed(p_day):
	emit_signal("day_changed", p_day)
	
func month_value_changed(p_month):
	emit_signal("month_changed", p_month)

func _ready():
	day_option = get_node("Day")
	month_option = get_node("Month")
	assert(day_option)
	assert(month_option)
	
	month_option.clear()
	for i in range(Time.MONTH_JANUARY, Time.MONTH_DECEMBER + 1):
		month_option.add_item(DateAndTime.get_string_from_month(i))
	
	assert(day_option.connect("value_changed", Callable(self, "day_value_changed")) == OK)
	assert(month_option.connect("item_selected", Callable(self, "month_value_changed")) == OK)
	
	set_disabled(disabled)
	
func set_day(p_value):
	if(!day_option):
		day_option = get_node("Day")
	day_option.set_value(p_value)
	
func set_month(p_idx):
	if(!month_option):
		month_option = get_node("Month")
	month_option.select(p_idx)
