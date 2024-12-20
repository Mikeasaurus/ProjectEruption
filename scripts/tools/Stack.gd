class_name Stack

var _stack = []

func push(value: Variant) -> void:
	_stack.append(value)

func pop() -> Variant:
	return _stack.pop_back()

func head() -> Variant:
	if(_stack.size() == 0):
		return null
	return _stack[_stack.size() -1]

func has(value: Variant) -> bool: 
	return _stack.has(value)
	
func remove(value: Variant) -> void:
	for i in range(_stack.size()):
		if _stack[i] == value:
			_stack.remove_at(i)
			return
