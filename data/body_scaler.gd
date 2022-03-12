const conversion_const = preload("./conversion.gd")

const COMMAND_SCALE = 0
const COMMAND_POSITION = 1

class ScalerCommand extends Resource:
	@export var command_id: int = COMMAND_SCALE
	@export var command_value: Vector3 = Vector3(1.0, 1.0, 1.0)
	@export var inverse: bool = false
	@export var min_value: float = 0.0
	@export var max_value: float = 1.0
	
	static func get_command_type_from_string(p_string):
		var lower_string = p_string.to_lower()
		
		if(lower_string == "scale"):
			return COMMAND_SCALE
		elif(lower_string == "position"):
			return COMMAND_POSITION
		else:
			return -1
			
	static func get_string_from_command_type(p_command_type):
		if(p_command_type == COMMAND_SCALE):
			return "scale"
		elif(p_command_type == COMMAND_POSITION):
			return "position"
		else:
			""
	
	func load_record(p_dictionary):
		command_id = get_command_type_from_string(p_dictionary.command_id)
		command_value = conversion_const.convert_string_to_vector_3(p_dictionary.command_value)
		inverse = p_dictionary.inverse
		min_value = p_dictionary.min_value
		max_value = p_dictionary.max_value
		
	func save_record():
		var dictionary = {}
		dictionary.command_id = get_string_from_command_type(command_id)
		dictionary.command_value = command_value
		dictionary.inverse = inverse
		dictionary.min_value = min_value
		dictionary.max_value = max_value
		
		return dictionary
		
class ScalerBone extends Resource:
	@export var scaler_commands: Array = []
	
	func load_record(p_dictionary):
		if(p_dictionary.has("scaler_commands")):
			for scale_command_dict in p_dictionary.scaler_commands:
				var scaler_command = ScalerCommand.new()
				scaler_command.load_record(scale_command_dict)
				scaler_commands.append(scaler_command)
				
	func save_record():
		var dictionary = {}
		var scaler_commands_dict_array = []
		for scaler_command in scaler_commands:
			scaler_commands_dict_array.append(scaler_command.save_record())
			
		dictionary.scaler_commands = scaler_commands_dict_array
		
		return dictionary
