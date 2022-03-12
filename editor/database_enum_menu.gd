@tool
extends Popup

var enum_tree: Tree = null
var enum_names = []

signal enum_selected(p_enum)

func _notification(what):
	if(what == Popup.NOTIFICATION_POST_POPUP):
		get_node("EnumListContainer/ButtonContainer/SelectButton").set_disabled(true)

func set_enums(p_enum_names, p_enum_values):
	if(enum_tree):
		enum_tree.clear()
		var root = enum_tree.create_item(null)
		enum_tree.set_hide_root(true)

		enum_names = p_enum_names

		for i in range(0, enum_names.size()):
			var tree_item = enum_tree.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, p_enum_names[i])
			tree_item.set_metadata(0, p_enum_values[i])

func confirm_enum_selection(p_enum):
	emit_signal("enum_selected", p_enum)
	hide()

func _ready():
	enum_tree = get_node("EnumListContainer/EnumTree")
	assert(enum_tree)

	enum_tree.set_select_mode(Tree.SELECT_SINGLE)

func _on_SelectButton_pressed():
	if(enum_tree):
		var tree_item = enum_tree.get_selected()
		if(tree_item):
			var id = tree_item.get_metadata(0)
			if(id):
				confirm_enum_selection(id)
				
func _on_CancelButton_pressed():
	hide()


func _on_EnumTree_cell_selected():
	if(enum_tree):
		var tree_item = enum_tree.get_selected()
		if(tree_item):
			get_node("EnumListContainer/ButtonContainer/SelectButton").set_disabled(false)
