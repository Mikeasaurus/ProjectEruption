extends Node2D
class_name Lane

const noteFactory = preload("res://scenes/LaneNote.tscn")

signal isCatchable
signal isMissed

const DEFAULT_WIDTH = 2.

var noteType: int
var startPos: Vector2
var endPos: Vector2

func initialize(noteType: int, pos: Vector2, length: float):
	self.noteType = noteType
	self.position = pos
	match (noteType):
		NoteTypes.RIGHT_LANE.noteId:
			$laneContainer.size = Vector2(length, DEFAULT_WIDTH)
			$laneContainer.position = Vector2(0, -1. * DEFAULT_WIDTH / 2.)
			self.startPos = Vector2(length, 0)
			self.endPos = Vector2(0, 0)
		NoteTypes.TOP_LANE.noteId:
			$laneContainer.size = Vector2(DEFAULT_WIDTH, length)
			$laneContainer.position = Vector2(-1. * DEFAULT_WIDTH / 2., 0)
			self.startPos = Vector2(0, 0)
			self.endPos = Vector2(0, length)
		NoteTypes.LEFT_LANE.noteId:
			$laneContainer.size = Vector2(length, DEFAULT_WIDTH)
			$laneContainer.position = Vector2(0, -1. * DEFAULT_WIDTH / 2.)
			self.startPos = Vector2(0, 0)
			self.endPos = Vector2(length, 0)

func initNote():
	var note = noteFactory.instantiate()
	note.initialize(self.noteType, self.startPos, self.endPos)
	self.add_child(note)

func warnCatchable():
	print("awa")
