extends CharacterBody2D

# Скорость движения персонажа
var speed = 200
const ESC_HOLD_TIME = 1.5  # Время удержания ESC для выхода
var esc_timer = 0.0  # Таймер для удержания ESC
var menu_open = false  # Состояние меню

# Узлы интерфейса (панель меню)
@onready var menu_panel = $"../CanvasLayer/Control"  # Основная панель меню

#func _ready():
	# Скрываем меню при старте
	# menu_panel.visible = false

func _process(delta):
	# Обнуляем скорость перед каждым кадром
	var direction = Vector2.ZERO

	# Открытие/закрытие меню
	if Input.is_action_just_pressed("open_menu"):
		toggle_menu()

	# Логика выхода при удержании ESC
	if Input.is_action_pressed("ui_cancel"):
		esc_timer += delta
		if esc_timer >= ESC_HOLD_TIME:
			get_tree().quit()  # Выход из игры
	else:
		esc_timer = 0.0  # Сброс таймера, если ESC отпущен

	# Если меню открыто, персонаж не должен двигаться
	if menu_open:
		return

	# Проверяем нажатие клавиш и задаем направление движения
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	# Если есть движение, выбираем соответствующую анимацию
	if direction != Vector2.ZERO:
		direction = direction.normalized() * speed


		# Прямые направления
		if direction.x > 0:
			$AnimatedSprite2D.play("right")
		elif direction.x < 0:
			$AnimatedSprite2D.play("left")
		elif direction.y < 0:
			$AnimatedSprite2D.play("up")
		elif direction.y > 0:
			$AnimatedSprite2D.play("down")

	# Применяем движение к встроенной переменной velocity
	velocity = direction

	# Используем встроенную функцию move_and_slide(), которая теперь работает с встроенной velocity
	move_and_slide()

# Функция для переключения меню
func toggle_menu():
	menu_open = not menu_open  # Переключаем состояние меню
	menu_panel.visible = menu_open  # Меняем видимость панели меню
