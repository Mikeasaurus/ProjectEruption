extends Node
class_name CatcherSpriteStateManager

const ENABLED = "catcherEnabled"
const NOTE_CATCHED = "noteCatched"

var lastState: bool
var animator: AnimationPlayer
var noteId: int

func _init(anim: AnimationPlayer, type: int) -> void:
	self.animator = anim
	self.lastState = false
	self.noteId = type
	Overseer.lane_changed.connect(_on_lane_changed)
	Overseer.lane_note_catched.connect(_on_lane_note_catched)
	
func _on_lane_changed(lane: int) -> void:
	self.changeState(lane == self.noteId)

func _on_lane_note_catched(lane: int) -> void:
	if(lane == self.noteId):
		if(self.animator.is_playing()):
			self.animator.pause()
			self.animator.seek(0)
		self.animator.play(NOTE_CATCHED)

func changeState(state: bool):
	if(state == self.lastState):
		return
	self.lastState = state
	if(self.animator.is_playing()):
		self.animator.seek(0.)
	if(!state):
		self.animator.speed_scale = 0.5
		self.animator.play_backwards(ENABLED)
	else:
		self.animator.speed_scale = 1
		self.animator.play(ENABLED)
