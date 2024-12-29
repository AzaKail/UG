extends Node

var menu_open = false  # Открыто ли меню
var selected_index = 0  # Индекс выбранного пункта меню
var menu_options = ["Items", "Stats"]  # Пункты меню (список)

# Узлы
@onready var menu_panel = get_node("/root/MainScene/CanvasLayer/Control")
@onready var items_button = get_node("/root/MainScene/CanvasLayer/Control/VBoxContainer/Items")
@onready var stats_button = get_node("/root/MainScene/CanvasLayer/Control/VBoxContainer/Stats")

# Иконка сердца (Загрузи спрайт зелёного сердца в проект и укажи его путь)
@onready var heart_icon = preload("res://sprites/minimenu/greensoulmini.png")

func _ready():
	update_button_icons()  # При открытии меню сразу обновляем иконки

func _process(_delta):
	if Input.is_action_just_pressed("open_menu"):
		toggle_menu()

	if menu_open:
		navigate_menu()

func toggle_menu():
	menu_open = not menu_open
	menu_panel.visible = menu_open
	if menu_open:
		selected_index = 0
		update_button_icons()

func navigate_menu():
	if Input.is_action_just_pressed("ui_down"):
		selected_index += 1
		if selected_index >= menu_options.size():
			selected_index = 0
		update_button_icons()

	elif Input.is_action_just_pressed("ui_up"):
		selected_index -= 1
		if selected_index < 0:
			selected_index = menu_options.size() - 1
		update_button_icons()

	if Input.is_action_just_pressed("accept_menu"):
		confirm_selection()

func update_button_icons():
	# Сбрасываем иконки у всех кнопок
	items_button.icon = null
	stats_button.icon = null

	# Назначаем иконку активной кнопке
	match selected_index:
		0:
			items_button.icon = heart_icon  # Добавляем сердце в Items
		1:
			stats_button.icon = heart_icon  # Добавляем сердце в Stats

func confirm_selection():
	if selected_index == 0:
		show_items_menu()
	elif selected_index == 1:
		show_stats_menu()

func show_items_menu():
	print("Items menu selected!")
	# Добавь сюда логику отображения подменю Items

func show_stats_menu():
	print("Stats menu selected!")
	# Добавь сюда логику отображения подменю Stats
