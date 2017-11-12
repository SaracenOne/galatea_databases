tool
extends Control

const generic_record_const = preload("../databases/generic_record.gd")

var record_tree = null

var database_new_edit_record_popup = null
var error_dialog = null

signal submit_new_record(p_name)
signal submit_renamed_record(p_from, p_to)
signal submit_erase_record(p_name)
signal set_current_record(p_record)

func _init():
	database_new_edit_record_popup = preload("database_new_edit_record_popup.tscn").instance()
	database_new_edit_record_popup.set_hide_on_ok(false)
	add_child(database_new_edit_record_popup)
	
	error_dialog = AcceptDialog.new()
	error_dialog.set_exclusive(true)
	add_child(error_dialog)
	pass
	
func new_record_duplicate_callback():
	error_dialog.set_text("A record of this name already exists...")
	error_dialog.get_label().set_align(Label.ALIGN_CENTER)
	error_dialog.popup_centered_minsize(Vector2(200, 100))

func new_record_add_successful_callback(p_database, p_record):
	add_record_dismissed_callback()
	database_new_edit_record_popup.hide()
	populate_tree(p_database, p_record)
	
func add_record_dismissed_callback():
	database_new_edit_record_popup.disconnect("name_entry_commit", self, "add_record_name_received")
	database_new_edit_record_popup.disconnect("popup_hide", self, "add_record_dismissed_callback")
	
func add_record_name_received(p_string):
	var ascii_string = p_string.to_ascii()
	
	if(ascii_string.size() == 0):
		error_dialog.set_text("Please input a valid name...")
		error_dialog.get_label().set_align(Label.ALIGN_CENTER)
		error_dialog.popup_centered_minsize(Vector2(200, 100))
	elif(ascii_string.size() > generic_record_const.MAX_ID_SIZE):
		error_dialog.set_text("Record name exeeds maximum string length!")
		error_dialog.get_label().set_align(Label.ALIGN_CENTER)
		error_dialog.popup_centered_minsize(Vector2(200, 100))
	else:
		emit_signal("submit_new_record", p_string)
		
func rename_record_successful_callback(p_database, p_record):
	rename_record_dismissed_callback()
	database_new_edit_record_popup.hide()
	populate_tree(p_database, p_record)
	
func rename_record_dismissed_callback():
	database_new_edit_record_popup.disconnect("name_entry_commit", self, "rename_record_name_received")
	database_new_edit_record_popup.disconnect("popup_hide", self, "rename_record_dismissed_callback")
		
func rename_record_name_received(p_string):
	var ascii_string = p_string.to_ascii()
	
	if(ascii_string.size() == 0):
		error_dialog.set_text("Please input a valid id...")
		error_dialog.get_label().set_align(Label.ALIGN_CENTER)
		error_dialog.popup_centered_minsize(Vector2(200, 100))
	elif(ascii_string.size() > generic_record_const.MAX_ID_SIZE):
		error_dialog.set_text("Record name exeeds maximum string length!")
		error_dialog.get_label().set_align(Label.ALIGN_CENTER)
		error_dialog.popup_centered_minsize(Vector2(200, 100))
	else:
		var tree_item = record_tree.get_selected()
		var record = tree_item.get_metadata(0)
		emit_signal("submit_renamed_record", record.id, p_string)
		
func erase_record_successful_callback(p_database):
	database_new_edit_record_popup.hide()
	populate_tree(p_database, null)
	
func _on_AddButton_pressed():
	database_new_edit_record_popup.set_instructions_text("Please give an id for the new record...")
	
	database_new_edit_record_popup.connect("name_entry_commit", self, "add_record_name_received")
	database_new_edit_record_popup.connect("popup_hide", self, "add_record_dismissed_callback")
	
	database_new_edit_record_popup.popup_centered()

func _on_EraseButton_pressed():
	var tree_item = record_tree.get_selected()
	if(tree_item):
		var record = tree_item.get_metadata(0)
		emit_signal("submit_erase_record", record.id)

func _on_RenameButton_pressed():
	var tree_item = record_tree.get_selected()
	if(tree_item):
		database_new_edit_record_popup.set_instructions_text(str("Please give a new id for the record '%s'...") % (tree_item.get_text(0)))
		database_new_edit_record_popup.connect("name_entry_commit", self, "rename_record_name_received")
		database_new_edit_record_popup.connect("popup_hide", self, "rename_record_dismissed_callback")
		
		database_new_edit_record_popup.popup_centered()

func populate_tree(p_database, p_selection_record):
	if(record_tree and p_database):
		record_tree.clear()
		var root = record_tree.create_item(null)
		record_tree.set_hide_root(true)
		var database_record_keys = p_database.database_records.keys()
		database_record_keys.sort()
		for key in database_record_keys:
			var record = p_database.database_records[key]
			var tree_item = record_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, record.id)
			tree_item.set_metadata(0, record)
			if(record == p_selection_record):
				tree_item.select(0)
	else:
		printerr("Record Tree is null!")
		
func _ready():
	record_tree = get_node("DatabaseRecordsContainer/RecordTree")
	assert(record_tree)
	
	record_tree.set_select_mode(Tree.SELECT_SINGLE)
	
func _on_RecordTree_item_selected():
	pass

func _on_RecordTree_cell_selected():
	var tree_item = record_tree.get_selected()
	var record = tree_item.get_metadata(0)
	
	get_node("DatabaseRecordsContainer/ButtonContainer/EraseButton").set_disabled(false)
	get_node("DatabaseRecordsContainer/ButtonContainer/RenameButton").set_disabled(false)
	
	emit_signal("set_current_record", record)
