extends VBoxContainer
class_name ScoreManager

const COMBO_FAILED = "comboFail"
const COMBO_ADD = "comboAdd"

var time = [0,0]

var comboLabel: Label
var scoreLabel: Label
var timeLabel: Label
var perfIcon: TextureRect

var ticker : Timer
var animator : AnimationPlayer

func _ready() -> void:
	self.comboLabel = $comboM/comboR/combo
	self.scoreLabel = $scoreM/score
	self.timeLabel = $timeM/time
	self.perfIcon = $perfectM/perfect
	self.perfIcon.scale = Vector2(0.2,0.2) # how
	self.ticker = $ticker
	self.animator = $comboM/comboAnim
	self.ticker.start(1)
	
	Overseer.combo_changed.connect(_on_combo_changed)
	Overseer.score_changed.connect(_on_score_change)
	Overseer.combo_failed.connect(_on_combo_failed)

func _on_combo_changed(combo: int):
	self.comboLabel.text = "%d" % combo
	if(combo > 0):
		if(self.animator.is_playing()):
			self.animator.pause()
			self.animator.seek(0)
		self.animator.play(COMBO_ADD)

func _on_combo_failed():
	_on_combo_changed(0)
	self.perfIcon.visible = false
	self.animator.play(COMBO_FAILED)

func _on_score_change(score: int):
	var text = ""
	while score >= 1000:
		text = " %03d%s" % [score % 1000, text]
		score /= 1000
	text = "%d%s" % [score, text]
	self.scoreLabel.text = text

func _on_ticker_timeout() -> void:
	self.time[1] += 1
	if(self.time[1] == 60):
		self.time[0] += 1
		self.time[1] = 0
	self.timeLabel.text = "%d:%02d" % self.time
	self.ticker.start(1)
