extends Node
class_name CenterSpriteAnimator

const NOTE_CATCHED = "noteCatched"

var animator: AnimationPlayer

func _init(animator : AnimationPlayer) -> void:
	self.animator = animator
	Overseer.lane_note_catched.connect(_on_lane_note_catched)

func _on_lane_note_catched(_lane: int) -> void:
	if(self.animator.is_playing()):
		self.animator.pause()
		self.animator.seek(0)
	self.animator.play(NOTE_CATCHED)
	
# extends Node
# class_name CenterSpriteAnimator

# const LEFT_CATCHED = "leftBg"
# const RIGHT_CATCHED = "rightBg"
# const TOP_CATCHED = "topBg"

# var animator: AnimationPlayer

# func _init(animator : AnimationPlayer) -> void:
# 	self.animator = animator
# 	Overseer.combo_mult.connect(_on_combo_mult)

# func _on_combo_mult(lane: int) -> void:
# 	if(self.animator.is_playing()):
# 		self.animator.pause()
# 		self.animator.seek(0)
# 	match(lane):
# 		NoteTypes.LEFT_LANE.noteId:
# 			self.animator.play(LEFT_CATCHED)
# 		NoteTypes.RIGHT_LANE.noteId:
# 			self.animator.play(RIGHT_CATCHED)
# 		_:
# 			self.animator.play(TOP_CATCHED)
