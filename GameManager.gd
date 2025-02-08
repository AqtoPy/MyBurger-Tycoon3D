extends Node

# Основные переменные
var rubles = 0  # Игровая валюта
var player_level = 1  # Уровень игрока
var experience = 0  # Опыт
var experience_to_next_level = 100  # Опыт для следующего уровня

# Рецепты
var recipes = {
    "Классический бургер": {"булка": 1, "говяжья котлета": 1, "цена": 100},
    "Чизбургер": {"булка": 1, "говяжья котлета": 1, "сыр чеддер": 2, "цена": 120},
}

# Оборудование
var equipment = {
    "grill": {"unlocked": false, "effect": 1.5},  # Гриль
    "fryer": {"unlocked": false, "effect": 1.2},  # Фритюрница
    "coffee_machine": {"unlocked": false, "effect": 1.1},  # Кофемашина
}

# Функция для добавления рублей
func add_rubles(amount):
    rubles += amount
    UI.update_rubles(rubles)  # Обновляем UI

# Функция для добавления опыта
func add_experience(amount):
    experience += amount
    if experience >= experience_to_next_level:
        level_up()

# Функция для повышения уровня
func level_up():
    player_level += 1
    experience -= experience_to_next_level
    experience_to_next_level = int(experience_to_next_level * 1.5)  # Увеличиваем требуемый опыт
    UI.update_level(player_level)  # Обновляем UI
    UI.show_message("Уровень повышен! Текущий уровень: " + str(player_level))
    unlock_new_features()

# Функция для разблокировки новых возможностей
func unlock_new_features():
    match player_level:
        2:
            UI.show_message("Разблокирован новый рецепт: Чизбургер!")
            recipes["Чизбургер"] = {"булка": 1, "говяжья котлета": 1, "сыр чеддер": 2, "цена": 120}
        3:
            UI.show_message("Разблокировано новое оборудование: Гриль!")
            unlock_equipment("grill")
            recipes["Бургер с грилем"] = {"булка": 1, "говяжья котлета": 1, "сыр чеддер": 1, "гриль": 1, "цена": 150}
        5:
            UI.show_message("Разблокировано новое оборудование: Фритюрница!")
            unlock_equipment("fryer")
            recipes["Картошка фри"] = {"картошка": 1, "цена": 50}

# Функция для разблокировки оборудования
func unlock_equipment(equipment_name):
    if equipment_name in equipment:
        equipment[equipment_name]["unlocked"] = true
        UI.show_message("Оборудование разблокировано: " + equipment_name)
        UI.update_equipment_list(equipment)
        
        # Делаем оборудование видимым
        match equipment_name:
            "grill":
                $BurgerRestaurant/Kitchen/Grill.visible = true
            "fryer":
                $BurgerRestaurant/Kitchen/Fryer.visible = true
            "coffee_machine":
                $BurgerRestaurant/Kitchen/CoffeeMachine.visible = true
    else:
        UI.show_message("Оборудование не найдено.")
