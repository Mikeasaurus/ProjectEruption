extends Node2D
class_name Catcher

var centerAnim : AnimationPlayer

func _ready() -> void:
	centerCatcher()
	animateCatchers()
	animateLines()
	animateCatching()

func centerCatcher() -> void:
	self.position = Vector2(
		DisplayServer.window_get_size().x / 2. - $body.size.x / 2.,
		DisplayServer.window_get_size().y - $body.size.y)

func animateCatchers() -> void:
	CatcherSpriteStateManager.new(
		$body/horizontalCatchers/leftNote/leftAnim,
		NoteTypes.LEFT_LANE.noteId)
	CatcherSpriteStateManager.new(
		$body/horizontalCatchers/rightNote/rightAnim, 
		 NoteTypes.RIGHT_LANE.noteId)
	CatcherSpriteStateManager.new(
		$body/verticalCatchers/topNote/topAnim, 
		NoteTypes.TOP_LANE.noteId)

func animateCatching() -> void:
	CenterSpriteAnimator.new(
		$body/center/meter/energyAnim
	)
	pass

func animateLines() -> void:
	CenterLineSpriteStateManager.new(
		$body/center/chords/chordLeftM/leftAnim,
		NoteTypes.LEFT_LANE.noteId
	)
	CenterLineSpriteStateManager.new(
		$body/center/chords/chordTopM/topAnim,
		NoteTypes.TOP_LANE.noteId
	)
	CenterLineSpriteStateManager.new(
		$body/center/chords/chordRightM/rightAnim,
		NoteTypes.RIGHT_LANE.noteId
	)
