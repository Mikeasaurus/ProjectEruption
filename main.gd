extends Node2D

var laneFactory = preload("res://scenes/Lane.tscn")
var catcherFactory = preload("res://scenes/Catcher.tscn")

var leftLane : Lane
var rightLane : Lane
var topLane : Lane

func _ready() -> void:
	self.initDebug()
	self.initLanes()
	self.initCatcher()
	self.playSequenceTest()
	
func initDebug() -> void:
	Overseer.lane_changed.connect(_on_lane_changed)
	Overseer.chord_pressed.connect(_on_chord_pressed)
	Overseer.drop_pressed.connect(_on_drop_pressed)

func initCatcher() -> void:
	var catcherO = catcherFactory.instantiate()
	self.add_child(catcherO)

func initLanes() -> void:
	var laneContainer = $lanes
	self.leftLane = laneFactory.instantiate()
	self.topLane = laneFactory.instantiate()
	self.rightLane = laneFactory.instantiate()
	
	var padding = 0.
	var square = 400.
	var length = 400.
	
	leftLane.initialize(
		NoteTypes.LEFT_LANE.noteId,
		Vector2(padding, padding + length + square / 2),
		length)
	topLane.initialize(
		NoteTypes.TOP_LANE.noteId,
		Vector2(padding + length + square / 2, padding),
		length)
	rightLane.initialize(
		NoteTypes.RIGHT_LANE.noteId,
		Vector2(padding + length + square, padding + length + square / 2),
		length)
	laneContainer.add_child(leftLane)
	laneContainer.add_child(topLane)
	laneContainer.add_child(rightLane)
	
	var width = padding * 2 + length * 2 + square
	var height = padding + length + square
	
	laneContainer.position = Vector2(
		DisplayServer.window_get_size().x / 2 - width / 2,
		DisplayServer.window_get_size().y - height
	)
	
func playSequenceTest() -> void:
	while true: # temp
		await get_tree().create_timer(randf_range(.2,.8)).timeout
		#await get_tree().create_timer(.2).timeout
		match (randi_range(0,2)):
			0:
				leftLane.initNote()
			1:
				rightLane.initNote()
			_:
				topLane.initNote()

func _on_chord_pressed(chord: int) -> void:
	$score/debug/chordLabel.text = 'Chord %d' % chord

func _on_lane_changed(lane: int) -> void:
	$score/debug/laneLabel.text = 'Lane %d' % lane
	
func _on_drop_pressed() -> void:
	$score/debug/dropLabel.text = "Drop !"
