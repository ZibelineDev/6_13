extends ProgressBar


func _ready() -> void :
	SoulSnatchManager.ref.snatching_progressed.connect(_on_snatching_progressed)
	SoulSnatchManager.ref.snatching_stopped.connect(_on_snatching_stopped)
	_reset()


func _progress(progress : float, _max_value : float) -> void :
	value = progress
	max_value = _max_value


func _reset() -> void :
	value = 0.0
	


func _on_snatching_progressed(progress : float, _max_value : float) -> void :
	_progress(progress, _max_value)


func _on_snatching_stopped() -> void :
	_reset()
