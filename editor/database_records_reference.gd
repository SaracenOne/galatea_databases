tool
extends Control

var record_tree = null
var database = null
var rules = []

var database_list_popup = preload("database_list.tscn").instance()

signal record_selected(p_record)
signal record_erased(p_record)
signal record_cell_selected(p_record)

export(bool) var disabled = false setget set_disabled, get_disabled

func set_disabled(p_bool):
	disabled = p_bool
	if(has_node("DatabaseRecordsReferenceContainer/ButtonContainer/AddButton")):
		var button = get_node("DatabaseRecordsReferenceContainer/ButtonContainer/AddButton")
		if(button):
			button.set_disabled(p_bool)

func get_disabled():
	return disabled

func _on_record_selected(p_record):
	emit_signal("record_selected", p_record)
		
func _on_AddButton_pressed():
	if(database):
		database_list_popup.populate_tree(database, rules)
		database_list_popup.popup_centered_ratio()

func _on_EraseButton_pressed():
	var tree_item = record_tree.get_selected()
	var record = tree_item.get_metadata(0)
	emit_signal("record_erased", record)
	
func populate_tree(p_records_array, p_selection_record):
	if(record_tree and p_records_array != null):
		record_tree.clear()
		var root = record_tree.create_item(null)
		record_tree.set_hide_root(true)
		for record in p_records_array:
			var tree_item = record_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, record.id)
			tree_item.set_metadata(0, record)
			if(record == p_selection_record):
				tree_item.select(0)
	else:
		printerr("Record Tree is null!")
		
func _ready():
	record_tree = get_node("DatabaseRecordsReferenceContainer/RecordTree")
	assert(record_tree)
	
	record_tree.set_select_mode(Tree.SELECT_SINGLE)
	
	add_child(database_list_popup)
	database_list_popup.connect("record_selected", self, "_on_record_selected")
	
func _on_RecordTree_item_selected():
	pass

func _on_RecordTree_cell_selected():
	var tree_item = record_tree.get_selected()
	var record = tree_item.get_metadata(0)
	
	if(has_node("DatabaseRecordsReferenceContainer/ButtonContainer/EraseButton")):
		get_node("DatabaseRecordsReferenceContainer/ButtonContainer/EraseButton").set_disabled(false)
		
	emit_signal("record_cell_selected", record)
		
func assign_database(p_database):
	database = p_database
		
func clear_rules():
	rules = []
	
func assign_rule(p_rule):
	rules.append(p_rule)