extends Node

signal chord_pressed(chord: int)
signal lane_changed(lane: int)
signal drop_pressed

signal lane_note_catched(lane: int)

signal score_changed(score: int)
signal combo_changed(combo: int)
signal combo_mult
signal combo_failed

const DEFAULT_COMBO_MULT = 25

var currentLane: int

var score: int
var combo: int
var best: int
var isPerfect: bool

func _ready() -> void:
	self.currentLane = NoteTypes.NONE.noteId
	self.score = 0
	self.combo = 0
	self.isPerfect = true

# Inputs warners
func changeLane(lane: int):
	self.currentLane = lane
	self.lane_changed.emit(lane)

func catchLaneNote(lane: int):
	self.lane_note_catched.emit(lane)

func pressChord(chord: int):
	self.chord_pressed.emit(chord)
	
func pressDrop():
	self.drop_pressed.emit()
	
# Score warners
func addToCombo():
	self.combo += 1
	self.combo_changed.emit(self.combo)
	if(self.combo % DEFAULT_COMBO_MULT == 0):
		self.combo_mult.emit()
	
func resetCombo():
	self.combo = 0
	self.isPerfect = false
	self.combo_failed.emit()
	
func addToScore(score: int):
	self.score += score
	self.score_changed.emit(self.score)
