@tool
extends Control

const generic_database_const = preload("../databases/generic_database.gd")

var editor_plugin: EditorPlugin = null
var editor_settings = null

func get_text_edit():
	return get_node("CodeEditor")
	
func _EDITOR_DEF( p_var, p_default):
	if (editor_plugin.get(p_var) != null):
		return editor_plugin.get(p_var)
	editor_plugin.set(p_var,p_default)
	return p_default
	
func EDITOR_DEF(m_var, m_val):
	return _EDITOR_DEF(m_var, m_val)

func load_theme_settings():
	get_text_edit().clear_colors()

	var keyword_color = EDITOR_DEF("text_editor/keyword_color",Color(0.5,0.0,0.2))
	
	var basetype_color= EDITOR_DEF("text_editor/base_type_color",Color(0.3,0.3,0.0))
	

	get_text_edit().add_keyword_color("Vector2",basetype_color)
	get_text_edit().add_keyword_color("Vector3",basetype_color)
	get_text_edit().add_keyword_color("Plane",basetype_color)
	get_text_edit().add_keyword_color("Quat",basetype_color)
	get_text_edit().add_keyword_color("AABB",basetype_color)
	get_text_edit().add_keyword_color("Matrix3",basetype_color)
	get_text_edit().add_keyword_color("Transform",basetype_color)
	get_text_edit().add_keyword_color("Color",basetype_color)
	get_text_edit().add_keyword_color("Image",basetype_color)
	get_text_edit().add_keyword_color("InputEvent",basetype_color)
	get_text_edit().add_keyword_color("Rect2",basetype_color)
	get_text_edit().add_keyword_color("NodePath",basetype_color)
	
	var type_color= EDITOR_DEF("text_editor/engine_type_color",Color(0.0,0.2,0.4))

func assign_editor_plugin(p_editor_plugin):
	if(editor_plugin == null):
		editor_plugin = p_editor_plugin
		editor_settings = editor_plugin.get_editor_settings()
		load_theme_settings()
