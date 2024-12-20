class_name Queue

var _queue = []

func push(value: Variant) -> void:
	_queue.append(value)

func pop() -> Variant:
	return _queue.pop_front()

func head() -> Variant:
	if(_queue.size() == 0):
		return null
	return _queue[0]

func has(value: Variant) -> bool: 
	return _queue.has(value)
	
func remove(value: Variant) -> void:
	for i in range(_queue.size()):
		if _queue[i] == value:
			_queue.remove_at(i)
			return
