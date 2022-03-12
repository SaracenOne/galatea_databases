@tool
extends ConfirmationDialog

var record_name_line_edit = null

signal name_entry_commit(p_string)

func _ready():
	if(!is_connected("confirmed", Callable(self, "_on_NewEditRecordDialog_confirmed"))):
		assert(connect("confirmed", Callable(self, "_on_NewEditRecordDialog_confirmed")) == OK)
	if(!is_connected("about_to_popup", Callable(self, "_on_NewEditRecordDialog_about_to_popup"))):
		assert(connect("about_to_popup", Callable(self, "_on_NewEditRecordDialog_about_to_popup")) == OK)
		
func _exit_tree():
	if(is_connected("confirmed", Callable(self, "_on_NewEditRecordDialog_confirmed"))):
		disconnect("confirmed", Callable(self, "_on_NewEditRecordDialog_confirmed"))
	if(is_connected("about_to_popup", Callable(self, "_on_NewEditRecordDialog_about_to_popup"))):
		disconnect("about_to_popup", Callable(self, "_on_NewEditRecordDialog_about_to_popup"))

func _notification(what):
	if(what == NOTIFICATION_POST_POPUP):
		get_node("NewEditRecordDialogContainer/RecordNameLineEdit").grab_focus()

func set_instructions_text(p_text):
	get_node("NewEditRecordDialogContainer/RecordInstructions").set_text(p_text)

func _on_record_name_line_edit_text_submitted(new_text):
	var record_name_line_edit = get_node("NewEditRecordDialogContainer/RecordNameLineEdit")
	emit_signal("name_entry_commit", record_name_line_edit.get_text())

func _on_NewEditRecordDialog_confirmed():
	var record_name_line_edit = get_node("NewEditRecordDialogContainer/RecordNameLineEdit")
	emit_signal("name_entry_commit", record_name_line_edit.get_text())

func _on_NewEditRecordDialog_about_to_popup():
	get_node("NewEditRecordDialogContainer/RecordNameLineEdit").set_text("")


