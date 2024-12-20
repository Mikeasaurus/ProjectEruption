extends Node

var chordsList = NoteTypes.getChordsList()

func _input(event: InputEvent):
	for ri in chordsList:
		var i = ri as NoteType
		if(event.is_action_pressed(i.noteEvent)):
			Overseer.pressChord(i.noteId)
