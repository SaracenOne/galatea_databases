tool
extends Control

var record_tree = null

var database_new_edit_record_popup = null
var error_dialog = null

signal record_selected(p_record)

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("Panel/HBoxContainer/ConfirmButton").set_disabled(true)
		
func confirm_record_selection(p_record):
	emit_signal("record_selected", p_record)
	hide()
		
func populate_tree(p_database):
	if(record_tree and p_database):
		record_tree.clear()
		var root = record_tree.create_item(null)
		record_tree.set_hide_root(true)
		for record in p_database.database_records:
			var tree_item = record_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, record.id)
			tree_item.set_metadata(0, record)
	else:
		printerr("Record Tree is null!")
		
func _ready():
	record_tree = get_node("RecordTree")
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
			get_node("Panel/HBoxContainer/ConfirmButton").set_disabled(false)