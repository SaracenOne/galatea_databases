@tool
extends Popup

var line_edit: LineEdit = null

signal text_selected(p_text)

func set_text(p_text):
	if(line_edit):
		line_edit.set_text(p_text)

func confirm_text_selection(p_text):
	emit_signal("text_selected", p_text)
	hide()

func _ready():
	line_edit = get_node("TextInputMenuContainer/LineEdit")
	assert(line_edit)

func _on_SelectButton_pressed():
	if(line_edit):
		confirm_text_selection(line_edit.get_text())

func _on_CancelButton_pressed():
	hide()
