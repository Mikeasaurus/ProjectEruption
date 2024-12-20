extends Node2D
class_name LaneNote

const CATCH_SCORE = 100
const DEFAULT_LEEWAY = .95
const DEFAULT_TIME = 1

var timeSpent : float
var maxTime : float

var noteType : int
var start : Vector2
var end : Vector2
var catched : bool

var fail: Sprite2D
var success: Sprite2D
var sprite: Sprite2D

const LEFT_TEXTURE = preload("res://textures/lane/LeftLaneNote.png")
const RIGHT_TEXTURE = preload("res://textures/lane/RightLaneNote.png")
const TOP_TEXTURE = preload("res://textures/lane/TopLaneNote.png")
const FAIL_TEXTURE = preload("res://textures/lane/FailLaneNote.png")

const LEFT_WAVE = preload("res://textures/lane/LeftCatchWave.png")
const TOP_WAVE = preload("res://textures/lane/TopCatchWave.png")
const RIGHT_WAVE = preload("res://textures/lane/RightCatchWave.png")

func initialize(noteType: int, start: Vector2, end: Vector2, duration = DEFAULT_TIME) -> void:
	self.catched = false
	self.sprite = $note
	self.fail = $fail
	self.success = $success
	
	self.maxTime = duration
	self.timeSpent = 0.
	
	self.sprite.position = start
	self.fail.position = end
	self.success.position = end
	
	self.noteType = noteType
	self.start = start
	self.end = end
	
	match (noteType):
		NoteTypes.LEFT_LANE.noteId:
			self.sprite.texture = LEFT_TEXTURE
			self.success.texture = LEFT_WAVE
		NoteTypes.RIGHT_LANE.noteId:
			self.sprite.texture = RIGHT_TEXTURE
			self.success.texture = RIGHT_WAVE
		_:
			self.sprite.texture = TOP_TEXTURE
			self.success.texture = TOP_WAVE

func updateProgression(prog: float) -> void:
	self.sprite.position = Vector2(
		(prog * self.end.x) + ((1. - prog)  * self.start.x),
		(prog * self.end.y) + ((1. - prog)  * self.start.y)
	)
	if(prog >= 1 and !self.catched):
		self.missNote()
	elif(prog > DEFAULT_LEEWAY and !self.catched):
		if(Overseer.currentLane == self.noteType):
			self.catchNote()
	
func missNote() -> void:
	Overseer.resetCombo()
	self.fail.visible = true
	$noteAnim.play("failWave")
	
func catchNote() -> void:
	Overseer.catchLaneNote(self.noteType)
	Overseer.addToCombo()
	Overseer.addToScore(CATCH_SCORE)
	self.catched = true
	self.success.visible = true
	$noteAnim.play("succWave")
	
func _process(_delta: float) -> void:
	self.timeSpent += _delta
	var ratio = self.timeSpent / self.maxTime
	self.updateProgression(ratio)

func _on_note_anim_animation_finished(anim_name: StringName) -> void:
	self.queue_free()
