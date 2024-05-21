extends Control

signal send_attack(index: int)
signal send_item(index: int)
signal send_mon(index: int)
signal send_run
enum BattleMenuPages { MAIN_PAGE, ATTACK_PAGE, ITEMS_PAGE, MONS_PAGE, RUN_PAGE }
var attack_page_attack_scene: PackedScene = load("res://ui/attack_page_attack.tscn")
var attacks: Array[Resource]
var current_option: Control = null
var current_option_index: int = 0
var battle: Node3D = null
@onready var tab_container: TabContainer = $TabContainer
@onready var current_option_hover: NinePatchRect = $CurrentOptionHover
@onready var menu_sound: AudioStreamPlayer = $MenuSound
@onready var main_page: Control = $TabContainer/MainPage
@onready var attack_page: Control = $TabContainer/AttackPage
@onready var items_page: Control = $TabContainer/ItemsPage
@onready var mons_page: Control = $TabContainer/MonsPage
@onready var run_page: Control = $TabContainer/RunPage


func _ready():
	battle = get_tree().get_root().get_node("Main/Battle")
	current_option = main_page.get_child(current_option_index)
	await get_tree().process_frame
	for i in attacks:
		var new_attack = attack_page_attack_scene.instantiate()
		attack_page.add_child(new_attack)
		new_attack.attack_label.text = i.attack_name


func _process(_delta):
	if visible:
		match tab_container.current_tab:
			BattleMenuPages.MAIN_PAGE:
				main_page_input()
			BattleMenuPages.ATTACK_PAGE:
				attack_page_input()
			BattleMenuPages.ITEMS_PAGE:
				items_page_input()
			BattleMenuPages.MONS_PAGE:
				mons_page_input()
			BattleMenuPages.RUN_PAGE:
				run_page_input()


func confirm_input():
	menu_sound.play()
	current_option_index = 0
	hide()


func reset_menu():
	menu_sound.play()
	tab_container.current_tab = BattleMenuPages.MAIN_PAGE
	current_option_index = 0


func main_page_input():
	up_down_input(main_page)
	if Input.is_action_just_pressed("confirm"):
		confirm_input()
		tab_container.current_tab = current_option_index + 1


func attack_page_input():
	up_down_input(attack_page)
	if Input.is_action_just_pressed("confirm"):
		send_attack.emit(current_option_index)
		confirm_input()
	if Input.is_action_just_pressed("cancel"):
		reset_menu()


func items_page_input():
	up_down_input(items_page)
	if Input.is_action_just_pressed("confirm"):
		send_item.emit(current_option_index)
		confirm_input()
	if Input.is_action_just_pressed("cancel"):
		reset_menu()


func mons_page_input():
	up_down_input(mons_page)
	if Input.is_action_just_pressed("confirm"):
		#send_mon.emit(current_option_index)
		confirm_input()
	if Input.is_action_just_pressed("cancel"):
		reset_menu()


func run_page_input():
	up_down_input(run_page)
	if Input.is_action_just_pressed("confirm"):
		if current_option_index == 0:
			send_run.emit()
			confirm_input()
		else:
			reset_menu()
	if Input.is_action_just_pressed("cancel"):
		reset_menu()


func up_down_input(page: Control):
	if Input.is_action_just_pressed("move_up"):
		menu_sound.play()
		current_option_index -= 1
		if current_option_index < 0:
			current_option_index = page.get_child_count() - 1
		current_option = page.get_child(current_option_index)
		current_option_hover.position.y = (current_option_index * 64 + current_option_index * 26)
	if Input.is_action_just_pressed("move_down"):
		menu_sound.play()
		current_option_index += 1
		if current_option_index >= page.get_child_count():
			current_option_index = 0
		current_option = page.get_child(current_option_index)
		current_option_hover.position.y = (current_option_index * 64 + current_option_index * 26)
