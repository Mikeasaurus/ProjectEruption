extends Node

var _laneStack = Stack.new()
var lanesList = NoteTypes.getLanesList()

func managePress(lane : int) -> void:
	if(_laneStack.has(lane)):
		_laneStack.remove(lane)
	_laneStack.push(lane)
	Overseer.changeLane(currentLane())

func manageRelease(lane: int) -> void:
	if lane == _laneStack.head():
		_laneStack.pop()
		Overseer.changeLane(currentLane())
	else:
		_laneStack.remove(lane)

func _input(event: InputEvent) -> void: 
	for ri in lanesList:
		var i = ri as NoteType
		if event.is_action(i.noteEvent):
			if event.is_action_released(i.noteEvent):
				manageRelease(i.noteId)
			elif event.is_action_pressed(i.noteEvent):
				managePress(i.noteId)
			return
			
func currentLane() -> int:
	var head = _laneStack.head()
	if head == null:
		return NoteTypes.NONE.noteId
	return head
