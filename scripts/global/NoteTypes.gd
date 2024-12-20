extends Node

var TOP_CHORD = NoteType.new(1, "topChord")
var RIGHT_CHORD = NoteType.new(2, "rightChord")
var BOTTOM_CHORD = NoteType.new(3, "bottomChord")
var LEFT_CHORD = NoteType.new(4, "leftChord")

var LEFT_LANE = NoteType.new(1, "leftLane")
var TOP_LANE = NoteType.new(2, "topLane")
var RIGHT_LANE = NoteType.new(3, "rightLane")

var LEFT_DROP = NoteType.new(1, "leftDrop")
var RIGHT_DROP = NoteType.new(2, "rightDrop")

var NONE = NoteType.new()

func getLanesList() -> Array:
	return [LEFT_LANE, TOP_LANE, RIGHT_LANE]

func getChordsList() -> Array:
	return [TOP_CHORD, RIGHT_CHORD, BOTTOM_CHORD, LEFT_CHORD]

func getDropsList() -> Array:
	return [LEFT_DROP, RIGHT_DROP]
