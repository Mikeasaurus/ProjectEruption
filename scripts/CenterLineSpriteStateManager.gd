extends Node
class_name CenterLineSpriteStateManager

const IDLE_TO_BLUR = "idleToBlur"

const IDLE_TO_ACTIVE = "idleToActive"
const ACTIVE_TO_IDLE = "activeToIdle"

const BLUR_TO_ACTIVE = "blurToActive"
const ACTIVE_TO_BLUR = "activeToBlur"

enum CenterLineState {
	IDLE = 0,
	ACTIVE = 1,
	BLUR = 2
}

var lastState : CenterLineState
var animator: AnimationPlayer
var noteId: int

func _init(animator : AnimationPlayer, type: int) -> void:
	self.lastState = CenterLineState.IDLE
	self.animator = animator
	self.noteId = type
	Overseer.lane_changed.connect(_on_line_changed)

func _on_line_changed(lane: int):
	var state = CenterLineState.IDLE
	if(lane == NoteTypes.NONE.noteId):
		state = 0
	elif(lane == self.noteId):
		state = 1
	else:
		state = 2
	self.changeState(state)

func changeState(state: CenterLineState):
	if(self.lastState == state):
		return
	self.animator.play("RESET")
	#if(self.animator.is_playing()):
	#	self.animator.pause()
	#	self.animator.seek(0.)
	match (self.lastState):
		CenterLineState.IDLE:
			if(state == CenterLineState.BLUR):
				self.animator.play(IDLE_TO_BLUR)
			else:
				self.animator.play(IDLE_TO_ACTIVE)
		CenterLineState.ACTIVE:
			if(state == CenterLineState.BLUR):
				self.animator.play(ACTIVE_TO_BLUR)
			else:
				self.animator.play(ACTIVE_TO_IDLE)
		_:
			if(state == CenterLineState.IDLE):
				self.animator.play_backwards(IDLE_TO_BLUR)
			else:
				self.animator.play(BLUR_TO_ACTIVE)
		
	self.lastState = state
