const COMPARISON_OPERATOR_EQUALS = 0
const COMPARISON_OPERATOR_NOT = 1
const COMPARISON_OPERATOR_GREATER = 2
const COMPARISON_OPERATOR_LESSER = 3
const COMPARSION_OPERATOR_EQUALS_OR_GREATER = 4
const COMPARISON_OPERATOR_EQUALS_OR_LESSER = 5

const CONDITIONAL_PROCESS_ON_SELF = 0
const CONDITIONAL_PROCESS_ON_TARGET = 1
const CONDITIONAL_PROCESS_ON_OBJECT = 2
const CONDITIONAL_PROCESS_ON_GLOBAL = 3

class ConditionalItem:
	var conditional_method = ""
	var arguments = []
	var operator = COMPARISON_OPERATOR_EQUALS
	var value = 1.0
	var process_on = CONDITIONAL_PROCESS_ON_SELF
	var use_or = false
	
var conditional_items = []
	
func compare_vars(p_lvar, p_rvar, p_comparison_operator):
	if(p_comparison_operator == COMPARISON_OPERATOR_EQUALS):
		return p_lvar == p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_NOT):
		return p_lvar != p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_GREATER):
		return p_lvar > p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_LESSER):
		return p_lvar < p_rvar
	elif(p_comparison_operator == COMPARSION_OPERATOR_EQUALS_OR_GREATER):
		return p_lvar >= p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_EQUALS_OR_LESSER):
		return p_lvar <= p_rvar
		
func run_conditional_items_for_subject(p_subject):
	if(p_subject):
		for i in range(0, conditional_items):
			var conditional = conditional_items[i]
			
			var l_var = null
			if(conditional.process_on == CONDITIONAL_PROCESS_ON_SELF):
				if(p_subject.has_method(conditional.conditional_method)):
					l_var = p_subject.callv(conditional.conditional_method, conditional.arguments)
				else:
					printerr("self has no method " + conditional.conditional_method + "!")
			
			var result = compare_vars(l_var, conditional.operator, conditional.value)
			if(result == false):
				if(conditional.use_or == false):
					return false
				else:
					if(conditional_items.size() <= i): # No further conditional items to compare so abort
						return false
			else:
				if(conditional.use_or == true):
					return true
	else:
		printerr("p_subject is NULL!")
		
static func string_to_operator(p_string):
	if(p_string == "=="):
		return COMPARISON_OPERATOR_EQUALS
	elif(p_string == "!="):
		return COMPARISON_OPERATOR_NOT
	elif(p_string == ">"):
		return COMPARISON_OPERATOR_GREATER
	elif(p_string == "<"):
		return COMPARISON_OPERATOR_LESSER
	elif(p_string == ">="):
		return COMPARSION_OPERATOR_EQUALS_OR_GREATER
	elif(p_string == "<="):
		return COMPARISON_OPERATOR_EQUALS_OR_LESSER
	else:
		printerr("string_to_operator: invalid!")
		return COMPARISON_OPERATOR_EQUALS
		
static func operator_to_string(p_operator):
	if(p_operator == COMPARISON_OPERATOR_EQUALS):
		return "=="
	elif(p_operator == COMPARISON_OPERATOR_NOT):
		return "!="
	elif(p_operator == COMPARISON_OPERATOR_GREATER):
		return ">"
	elif(p_operator == COMPARISON_OPERATOR_LESSER):
		return "<"
	elif(p_operator == COMPARSION_OPERATOR_EQUALS_OR_GREATER):
		return ">="
	elif(p_operator == COMPARISON_OPERATOR_EQUALS_OR_LESSER):
		return "<="
	else:
		printerr("operator_to_string: invalid!")
		return "=="
		
static func string_to_process_on(p_string):
	if(p_string == "self"):
		return CONDITIONAL_PROCESS_ON_SELF
	else:
		printerr("string_to_process_on: invalid!")
		return CONDITIONAL_PROCESS_ON_SELF
		
static func process_on_to_string(p_process_on):
	if(p_process_on == CONDITIONAL_PROCESS_ON_SELF):
		return "self"
	else:
		printerr("process_on_to_string: invalid!")
		return "self"
		
static func load_from_dictionary(p_dictionary, p_conditional_set):
	if(p_dictionary.has("conditional_items")):
		p_conditional_set.conditional_items.clear()
		
		for conditional_dictionary in p_dictionary.conditional_items:
			var conditional_item = ConditionalItem.new()
			
			conditional_item.conditional_method = conditional_dictionary.conditional_method
			
			conditional_item.arguments.clear()
			for argument in conditional_dictionary.arguments:
				conditional_item.push_back(argument)
				
			conditional_item.operator = string_to_operator(conditional_dictionary.operator)
			conditional_item.value = conditional_dictionary.value
			conditional_item.process_on = string_to_process_on(conditional_dictionary.process_on)
			conditional_item.use_or = conditional_dictionary.use_or
			
			p_conditional_set.push_back(conditional_item)
		
static func save_to_dictionary(p_dictionary, p_conditional_set):
	p_dictionary.conditional_items = []
	
	for conditional_item in p_conditional_set.conditional_items:
		var conditional_dictionary = {}
		
		conditional_dictionary.conditional_method = conditional_item.conditional_method
		
		for argument in conditional_item.arguments:
			conditional_dictionary.conditional_arguments.push_back(argument)
			
		conditional_dictionary.operator = operator_to_string(conditional_item.operator)
		conditional_dictionary.value = conditional_item.value
		conditional_dictionary.process_on = process_on_to_string(conditional_item.process_on)
		conditional_dictionary.use_or = conditional_item.use_or
		
		p_dictionary.conditional_items.push_back(conditional_dictionary)
		