@tool
extends Control

var first_enter = true
var rot_x = 0.0
var rot_y = 0.0

signal image_saved()

@export var max_zoom: float = 5.0
@export var min_zoom: float = 0.0
@export var zoom_rate: float = 1.0
@export var x_rotation: bool = true
@export var y_rotation: bool = true
@export var default_capture_filename: String = "": set = set_default_capture_filename

var zoom: float = 0.5
var follow_target: Vector3 = Vector3(0.0, 0.0, 0.0)

var viewport: Viewport = null
var mesh_instance: MeshInstance3D = null
var light1: Light3D = null
var light2: Light3D = null
var camera: Camera3D = null
var mesh: Mesh = null
var scene: Node3D = null

var editor_file_dialog: FileDialog = FileDialog.new()
var cached_image = null

func _notification(what):
	if what == Control.NOTIFICATION_RESIZED:
		if(viewport):
			viewport.set_size(get_size())

func _gui_input(p_event):
	if (p_event is InputEventMouseMotion and p_event.button_mask & MOUSE_BUTTON_MASK_LEFT):
		if(x_rotation):
			rot_x -= p_event.relative.y
		if(y_rotation):
			rot_y -= p_event.relative.x
		_update_rotation()
	if (p_event is InputEventMouseButton):
		if(p_event.button_index == MOUSE_BUTTON_WHEEL_UP):
			zoom -= 0.01 * zoom_rate
			_update_rotation()
		elif(p_event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			zoom += 0.01 * zoom_rate
			_update_rotation()

func _update_rotation():
	if(zoom < 0.0):
		zoom = 0.0
	elif(zoom > 5.0):
		zoom = 5.0
	
	camera.set_position(follow_target)
	camera.set_rotation(Vector3(0.0, 0.0, 0.0))
	camera.rotate(Vector3(0, -1, 0), deg2rad(rot_y))
	camera.rotate(Vector3(-1, 0, 0), deg2rad(rot_x))
	var end = Transform3D(camera.get_global_transform().basis, follow_target) * (Vector3(0.0, 0.0, zoom))
	camera.set_position(end)

func _ready():
	if (first_enter):
		first_enter = false
	
	viewport = get_node("Container/Viewport")
	viewport.set_size(get_size())
	viewport.set_update_mode(SubViewport.UPDATE_ALWAYS)
	
	#var environment = Environment.new()
	#environment.set_background(Environment.BG_CLEAR_COLOR)
	#environment.
	
	camera = Camera3D.new()
	camera.set_transform(Transform3D(Basis(),Vector3(0,0,3)))
	camera.set_perspective(45,0.0001,10000)
	#camera.set_environment(environment)
	viewport.add_child(camera)
	
	light1 = DirectionalLight3D.new()
	light1.set_transform(Transform3D().looking_at(Vector3(-1,-1,-1),Vector3(0,1,0)))
	viewport.add_child(light1)
	
	light2 = DirectionalLight3D.new()
	light2.set_transform(Transform3D().looking_at(Vector3(0,1,0),Vector3(0,0,1)))
	light2.light_color = (Color(0.7,0.7,0.7))
	light2.light_specular = (0.7)
	viewport.add_child(light2)
	
	mesh_instance = MeshInstance3D.new()
	viewport.add_child(mesh_instance)
	
	var hb = HBoxContainer.new()
	add_child(hb)
	#hb.set_area_as_parent_rect(2)
	
	hb.add_spacer(false)
	
	var vb_light = VBoxContainer.new()
	hb.add_child(vb_light)
	
	first_enter = true
	rot_x = 0
	rot_y = 0
	
	add_child(editor_file_dialog)
	
	editor_file_dialog.set_title("Save Image...")
	assert(editor_file_dialog.connect("file_selected", Callable(self, "_on_file_selected")) == OK)
	editor_file_dialog.set_mode(FileDialog.FILE_MODE_SAVE_FILE)
	editor_file_dialog.set_access(FileDialog.ACCESS_RESOURCES)
	editor_file_dialog.add_filter("*." + "png")
	editor_file_dialog.set_current_path("res://")

func set_mesh(p_mesh):
	mesh = p_mesh
	mesh_instance.set_mesh(mesh)
	
	rot_x = 0
	rot_y = 0

	var aabb: AABB = mesh_instance.get_aabb()
	follow_target = aabb.position + aabb.size * 0.5
	zoom = max(aabb.size.x,aabb.size.y)
	zoom += zoom
	
	_update_rotation()
			
func set_material(material):
	if(mesh_instance):
		mesh_instance.set_material_override(material)
		
func set_scene(p_scene):
	if(scene):
		scene.queue_free()
		viewport.remove_child(scene)
		scene = null
		
	if p_scene is Node3D:
		viewport.add_child(p_scene)
		scene = p_scene
		
		rot_x = 0
		rot_y = 0
		zoom = max_zoom
		
		_update_rotation()
		
func clear_scene():
	if(scene):
		scene.queue_free()
		viewport.remove_child(scene)
		scene = null
		
func _image_render_callback_complete(p_udata):
	_attempt_preview_image_retrieval()
		
func save_preview_image():
	RenderingServer.request_frame_drawn_callback(Callable(self, "_image_render_callback_complete"))
		
func _attempt_preview_image_retrieval():
		var image = viewport.get_texture().get_data()
		
		if(image != null and image.is_empty() == false):
			cached_image = image
			cached_image.convert(Image.FORMAT_RGBA8)
			cached_image.resize(512, 512)
			
			editor_file_dialog.set_current_file(default_capture_filename)
			editor_file_dialog.popup_centered_ratio()
			
func _on_file_selected(p_path):
	if(cached_image != null):
		cached_image.save_png(p_path)
		cached_image = null
		emit_signal("image_saved")
			
func set_default_capture_filename(p_name):
	default_capture_filename = p_name
