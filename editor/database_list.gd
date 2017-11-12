tool
extends Control

var record_tree = null

var database_new_edit_record_popup = null
var error_dialog = null

signal record_selected(p_record)

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("DatabaseListContainer/ButtonContainer/ConfirmButton").set_disabled(true)
		
func confirm_record_selection(p_record):
	emit_signal("record_selected", p_record)
	hide()
		
func populate_tree(p_database, p_rules = []):
	if(record_tree and p_database):
		record_tree.clear()
		var root = record_tree.create_item(null)
		record_tree.set_hide_root(true)
		for key in p_database.database_records.keys():
			var record = p_database.database_records[key]
			
			var rules_valid = true
			for rule in p_rules:
				if(rule.has("arg9")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4, rule.arg5, rule.arg6, rule.arg7, rule.arg8, rule.arg9) == false):
						rules_valid = false
				elif(rule.has("arg8")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4, rule.arg5, rule.arg6, rule.arg7, rule.arg8) == false):
						rules_valid = false
				elif(rule.has("arg7")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4, rule.arg5, rule.arg6, rule.arg7) == false):
						rules_valid = false
				elif(rule.has("arg6")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4, rule.arg5, rule.arg6) == false):
						rules_valid = false
				elif(rule.has("arg5")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4, rule.arg5) == false):
						rules_valid = false
				elif(rule.has("arg4")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3, rule.arg4) == false):
						rules_valid = false
				elif(rule.has("arg3")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2, rule.arg3) == false):
						rules_valid = false
				elif(rule.has("arg2")):
					if(record.call(rule.method, rule.arg0, rule.arg1, rule.arg2) == false):
						rules_valid = false
				elif(rule.has("arg1")):
					if(record.call(rule.method, rule.arg0, rule.arg1) == false):
						rules_valid = false
				elif(rule.has("arg0")):
					if(record.call(rule.method, rule.arg0) == false):
						rules_valid = false
				else:
					if(record.call(rule.method) == false):
						rules_valid = false
			
			if(rules_valid):
				var tree_item = record_tree.create_item(root)
				tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
				tree_item.set_text(0, record.id)
				tree_item.set_metadata(0, record)
	else:
		printerr("Record Tree is null!")
		
func _ready():
	record_tree = get_node("DatabaseListContainer/RecordTree")
	assert(record_tree)
	
	record_tree.set_select_mode(Tree.SELECT_SINGLE)
	
func _on_CancelButton_pressed():
	hide()

func _on_ConfirmButton_pressed():
	if(record_tree):
		var tree_item = record_tree.get_selected()
		if(tree_item):
			var record = tree_item.get_metadata(0)
			if(record):
				confirm_record_selection(record)
			
func _on_RecordTree_cell_selected():
	if(record_tree):
		var tree_item = record_tree.get_selected()
		if(tree_item):
			get_node("DatabaseListContainer/ButtonContainer/ConfirmButton").set_disabled(false)