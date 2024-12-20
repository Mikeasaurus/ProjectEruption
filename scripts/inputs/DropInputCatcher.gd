extends Node

var state = 0
var dropsList = NoteTypes.getDropsList()

func _input(event: InputEvent) -> void:
	for ri in dropsList:
		var i = ri as NoteType
		if(event.is_action(i.noteEvent)):
			if(event.is_action_pressed(i.noteEvent)):
				self.managePress()
			elif(event.is_action_released(i.noteEvent)):
				self.manageRelease()
			
func manageRelease():
	self.state =- 1

func managePress():
	self.state += 1
	if(self.state >= 2):
		Overseer.pressDrop()
