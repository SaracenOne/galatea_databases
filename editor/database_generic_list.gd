@tool
extends Popup

var list_tree: Tree = null

var database_new_edit_record_popup = null
var error_dialog = null

signal list_item_selected(p_item)

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("DatabaseListContainer/ButtonContainer/ConfirmButton").set_disabled(true)
		
func confirm_item_selection(p_item):
	emit_signal("list_item_selected", p_item)
	hide()
		
func populate_tree(p_list):
	if(list_tree and p_list != null):
		list_tree.clear()
		var root = list_tree.create_item(null)
		list_tree.set_hide_root(true)
		for list_item in p_list:
			var tree_item = list_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, list_item["name"])
			tree_item.set_metadata(0, list_item["data"])
	else:
		printerr("List tree is null!")
		
func _ready():
	list_tree = get_node("DatabaseListContainer/ListTree")
	assert(list_tree)
	
	list_tree.set_select_mode(Tree.SELECT_SINGLE)
	
func _on_CancelButton_pressed():
	hide()

func _on_ConfirmButton_pressed():
	if(list_tree):
		var tree_item = list_tree.get_selected()
		if(tree_item):
			var item = tree_item.get_metadata(0)
			if(item):
				confirm_item_selection(item)

func _on_ListTree_cell_selected():
	if(list_tree):
		var tree_item = list_tree.get_selected()
		if(tree_item):
			get_node("DatabaseListContainer/ButtonContainer/ConfirmButton").set_disabled(false)
