extends Control
signal resume_pressed
@onready var resume_button: Button = %ResumeButton
@onready var fullscreen_button: Button = %FullscreenButton
@onready var exit_button: Button = %ExitButton
@onready var master_slider: HSlider = %MasterSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var bgm_slider: HSlider = %BGMSlider


func _ready():
	master_slider.value_changed.connect(_on_volume_changed)
	sfx_slider.value_changed.connect(_on_volume_changed)
	bgm_slider.value_changed.connect(_on_volume_changed)
	resume_button.pressed.connect(_on_resume_pressed)
	fullscreen_button.pressed.connect(_on_fullscreen_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func _on_resume_pressed():
	emit_signal("resume_pressed")


func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_exit_pressed():
	get_tree().quit()


func _on_volume_changed(_value):
	if master_slider.value <= -20.0:
		master_slider.value = -80.0
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_slider.value)
	if sfx_slider.value <= -20.0:
		sfx_slider.value = -80.0
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_slider.value)
	if bgm_slider.value <= -20.0:
		bgm_slider.value = -80.0
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), bgm_slider.value)
