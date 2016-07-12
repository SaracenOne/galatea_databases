extends Control
tool

var day_option = null
var month_option = null
export(bool) var disabled = false setget set_disabled

signal day_changed(p_day)
signal month_changed(p_month)

func set_disabled(p_disabled):
	disabled = p_disabled
	if(day_option):
		day_option.set_editable(!p_disabled)
	if(month_option):
		month_option.set_disabled(p_disabled)

func day_value_changed(p_day):
	emit_signal("day_changed", p_day)
	
func month_value_changed(p_month):
	print(p_month)
	emit_signal("month_changed", p_month)

func _ready():
	day_option = get_node("Day")
	month_option = get_node("Month")
	
	day_option.connect("value_changed", self, "day_value_changed")
	month_option.connect("item_selected", self, "month_value_changed")
	
	set_disabled(disabled)
	
func set_day(p_value):
	if(!day_option):
		day_option = get_node("Day")
	day_option.set_value(p_value)
	
func set_month(p_idx):
	if(!month_option):
		month_option = get_node("Month")
	month_option.select(p_idx)