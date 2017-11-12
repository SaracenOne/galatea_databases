tool
extends Control

var spinbox = null

signal value_selected(p_value)

func set_value(p_value):
	if(spinbox):
		spinbox.set_value(p_value)
		
func set_step(p_step):
	if(spinbox):
		spinbox.set_step(p_step)

func confirm_numerical_selection(p_value):
	emit_signal("value_selected", p_value)
	hide()

func _ready():
	spinbox = get_node("NumericalMenuContainer/NumericalSpinbox")
	assert(spinbox)

func _on_SelectButton_pressed():
	if(spinbox):
		confirm_numerical_selection(spinbox.get_value())

func _on_CancelButton_pressed():
	hide()