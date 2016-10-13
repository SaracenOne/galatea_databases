tool
extends Control

var check_button = null

signal boolean_selected(p_bool)

func set_boolean(p_bool):
	if(check_button):
		check_button.set_pressed(p_bool)

func confirm_boolean_selection(p_bool):
	emit_signal("boolean_selected", p_bool)
	hide()

func _ready():
	check_button = get_node("CheckButton")
	assert(check_button)

func _on_SelectButton_pressed():
	if(check_button):
		confirm_boolean_selection(check_button.is_pressed())

func _on_CancelButton_pressed():
	hide()