tool

var record_name_line_edit = null

signal name_entry_commit(p_string)

func _ready():
	if(!is_connected("confirmed", self, "_on_NewEditRecordDialog_confirmed")):
		connect("confirmed", self, "_on_NewEditRecordDialog_confirmed")
	if(!is_connected("about_to_show", self, "_on_NewEditRecordDialog_about_to_show")):
		connect("about_to_show", self, "_on_NewEditRecordDialog_about_to_show")
		
func _exit_tree():
	if(is_connected("confirmed", self, "_on_NewEditRecordDialog_confirmed")):
		disconnect("confirmed", self, "_on_NewEditRecordDialog_confirmed")
	if(is_connected("about_to_show", self, "_on_NewEditRecordDialog_about_to_show")):
		disconnect("about_to_show", self, "_on_NewEditRecordDialog_about_to_show")

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("RecordNameLineEdit").grab_focus()

func set_instructions_text(p_text):
	get_node("RecordInstructions").set_text(p_text)

func _on_RecordNameLineEdit_text_entered( text ):
	var record_name_line_edit = get_node("RecordNameLineEdit")
	emit_signal("name_entry_commit", record_name_line_edit.get_text())

func _on_NewEditRecordDialog_confirmed():
	var record_name_line_edit = get_node("RecordNameLineEdit")
	emit_signal("name_entry_commit", record_name_line_edit.get_text())

func _on_NewEditRecordDialog_about_to_show():
	get_node("RecordNameLineEdit").set_text("")