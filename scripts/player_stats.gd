extends Node

# Основные параметры статистики персонажа
var LV = 1  # Уровень
var HP = 25  # Текущее здоровье
var MAX_HP = 25  # Максимальное здоровье
var ATK = 2  # Атака
var DEF = 5  # Защита
var EXP = 0  # Опыт
var GOLD = 0  # Золото




# Функция для отображения статистики
func show_stats():
	print("Level (LV): ", LV)
	print("HP: ", HP, "/", MAX_HP)
	print("ATK: ", ATK)
	print("DEF: ", DEF)
	print("EXP: ", EXP)
	print("Gold (G): ", GOLD)

# Функция для повышения уровня
func level_up():
	if EXP >= 100:
		LV += 1
		EXP = 0
		MAX_HP += 5
		ATK += 1
		DEF += 1
		print("Level up! LV is now ", LV)
		HP = MAX_HP  # Восстановление HP при уровне

# Вызываем отображение статистики
func _ready():
	show_stats()
