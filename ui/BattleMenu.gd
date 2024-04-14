extends Control

signal send_attack(index: int)
signal send_item(index: int)
signal send_mon(index: int)
signal send_run
enum BattleMenmove_downages { MAIN_PAGE, ATTACK_PAGE, ITEMS_PAGE, MONS_PAGE, RUN_PAGE }
var battle_options: Array[Control] = []
var current_option: Control = null
var current_option_index: int = 0
var battle: Node3D = null
@onready var tab_container: TabContainer = $TabContainer
@onready var current_option_hover: Panel = $CurrentOptionHover
@onready var menu_sound: AudioStreamPlayer = $MenuSound
@onready var main_page: Control = $TabContainer/MainPage
@onready var attack_page: Control = $TabContainer/AttackPage
@onready var items_page: Control = $TabContainer/ItemsPage
@onready var mons_page: Control = $TabContainer/MonsPage
@onready var run_page: Control = $TabContainer/RunPage


func _ready():
	battle = get_tree().get_root().get_node("Main/Battle")
	current_option = main_page.get_child(current_option_index)


func _process(_delta):
	var current_page = tab_container.current_tab
	match current_page:
		BattleMenmove_downages.MAIN_PAGE:
			if Input.is_action_just_pressed("move_up"):
				menu_sound.play()
				current_option_index -= 1
				if current_option_index < 0:
					current_option_index = main_page.get_child_count() - 1
				current_option = main_page.get_child(current_option_index)
			if Input.is_action_just_pressed("move_down"):
				menu_sound.play()
				current_option_index += 1
				if current_option_index >= main_page.get_child_count():
					current_option_index = 0
				current_option = main_page.get_child(current_option_index)
			current_option_hover.position.y = current_option_index * 64 + current_option_index * 26
			if Input.is_action_just_pressed("confirm"):
				menu_sound.play()
				tab_container.current_tab = current_option_index + 1
				current_option_index = 0
		BattleMenmove_downages.ATTACK_PAGE:
			if Input.is_action_just_pressed("move_up"):
				menu_sound.play()
				current_option_index -= 1
				if current_option_index < 0:
					current_option_index = attack_page.get_child_count() - 1
				current_option = attack_page.get_child(current_option_index)
			if Input.is_action_just_pressed("move_down"):
				menu_sound.play()
				current_option_index += 1
				if current_option_index >= attack_page.get_child_count():
					current_option_index = 0
				current_option = attack_page.get_child(current_option_index)
			current_option_hover.position.y = current_option_index * 64 + current_option_index * 26
			if Input.is_action_just_pressed("confirm"):
				menu_sound.play()
				send_attack.emit(current_option_index)
				hide()
			if Input.is_action_just_pressed("cancel"):
				menu_sound.play()
				tab_container.current_tab = BattleMenmove_downages.MAIN_PAGE
				current_option_index = 0
		BattleMenmove_downages.ITEMS_PAGE:
			if Input.is_action_just_pressed("move_up"):
				menu_sound.play()
				current_option_index -= 1
				if current_option_index < 0:
					current_option_index = items_page.get_child_count() - 1
				current_option = items_page.get_child(current_option_index)
			if Input.is_action_just_pressed("move_down"):
				menu_sound.play()
				current_option_index += 1
				if current_option_index >= items_page.get_child_count():
					current_option_index = 0
				current_option = items_page.get_child(current_option_index)
			current_option_hover.position.y = current_option_index * 64 + current_option_index * 26
			if Input.is_action_just_pressed("confirm"):
				menu_sound.play()
				send_item.emit(current_option_index)
				hide()
			if Input.is_action_just_pressed("cancel"):
				menu_sound.play()
				tab_container.current_tab = BattleMenmove_downages.MAIN_PAGE
				current_option_index = 0
		BattleMenmove_downages.MONS_PAGE:
			if Input.is_action_just_pressed("move_up"):
				menu_sound.play()
				current_option_index -= 1
				if current_option_index < 0:
					current_option_index = mons_page.get_child_count() - 1
				current_option = mons_page.get_child(current_option_index)
			current_option_hover.position.y = current_option_index * 64 + current_option_index * 26
			if Input.is_action_just_pressed("move_down"):
				menu_sound.play()
				current_option_index += 1
				if current_option_index >= mons_page.get_child_count():
					current_option_index = 0
				current_option = mons_page.get_child(current_option_index)
			if Input.is_action_just_pressed("confirm"):
				menu_sound.play()
				send_mon.emit(current_option_index)
				hide()
			if Input.is_action_just_pressed("cancel"):
				menu_sound.play()
				tab_container.current_tab = BattleMenmove_downages.MAIN_PAGE
				current_option_index = 0
		BattleMenmove_downages.RUN_PAGE:
			if Input.is_action_just_pressed("move_up"):
				menu_sound.play()
				current_option_index -= 1
				if current_option_index < 0:
					current_option_index = run_page.get_child_count() - 1
				current_option = run_page.get_child(current_option_index)
			current_option_hover.position.y = current_option_index * 64 + current_option_index * 26
			if Input.is_action_just_pressed("move_down"):
				menu_sound.play()
				current_option_index += 1
				if current_option_index >= run_page.get_child_count():
					current_option_index = 0
				current_option = run_page.get_child(current_option_index)
			if Input.is_action_just_pressed("confirm"):
				menu_sound.play()
				if current_option_index == 0:
					send_run.emit()
				else:
					tab_container.current_tab = BattleMenmove_downages.MAIN_PAGE
			if Input.is_action_just_pressed("cancel"):
				menu_sound.play()
				tab_container.current_tab = BattleMenmove_downages.MAIN_PAGE
				current_option_index = 0
