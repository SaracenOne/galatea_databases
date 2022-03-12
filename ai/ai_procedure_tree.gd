@tool
# Core of an AI package for determining an AI routine
enum ai_procedure_type {
	PROCEDURE_TYPE_NONE = 0,
	PROCEDURE_TYPE_TRAVEL,
	PROCEDURE_TYPE_WAIT,
	PROCEDURE_TYPE_WANDER,
	PROCEDURE_TYPE_ACTIVATE_OBJECT
}

class ProcedureTreeNode:
	var parent = null

class ProcedureTreeBranchNode:
	extends ProcedureTreeNode
	
	const BRANCH_TYPE_STACKED = 0
	const BRANCH_TYPE_SEQUENCE = 1
	const BRANCH_TYPE_RANDOM = 2
	const BRANCH_TYPE_SIMULTANEOUS = 3
	
	var branch_type = BRANCH_TYPE_SEQUENCE
	
	var children = []

class ProcedureTreeProcedureNode:
	extends ProcedureTreeNode
	
	var procedure_type = self.ai_procedure_type.PROCEDURE_TYPE_WAIT

var root = []

func insert_procedure_tree_node(p_node, p_parent=null):
	if(p_parent == null):
		root.push_back(p_node)
		p_node.parent = p_parent
		
func find_optimal_nodes(p_state_dictionary):
	pass
