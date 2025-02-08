extends Node

# Основные переменные
var rubles = 0  # Игровая валюта
var player_level = 1  # Уровень игрока
var experience = 0  # Опыт
var experience_to_next_level = 100  # Опыт для следующего уровня

# Список работников
var staff = []

# Функция для найма работника
func hire_staff():
    var cost = 5000  # Стоимость найма
    if rubles >= cost:
        add_rubles(-cost)
        staff.append("Новый работник")
        UI.show_message("Новый работник нанят!")
    else:
        UI.show_message("Недостаточно рублей для найма!")

# Рецепты
var recipes = {
    "Классический бургер": {"булка": 1, "говяжья котлета": 1, "цена": 100},
    "Чизбургер": {"булка": 1, "говяжья котлета": 1, "сыр чеддер": 2, "цена": 120},
}

# Оборудование
var equipment = {
    "grill": {"unlocked": false, "effect": 1.5, "new_recipes": ["Бургер с грилем"]},  # Гриль
    "fryer": {"unlocked": false, "effect": 1.2, "new_recipes": ["Картошка фри"]},  # Фритюрница
    "coffee_machine": {"unlocked": false, "effect": 1.1, "new_recipes": ["Кофе"]},  # Кофемашина
    "oven": {"unlocked": false, "effect": 1.3, "new_recipes": ["Пицца"]},  # Духовка
    "blender": {"unlocked": false, "effect": 1.1, "new_recipes": ["Смузи"]},  # Блендер
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
            "oven":
                $BurgerRestaurant/Kitchen/Oven.visible = true
            "blender":
                $BurgerRestaurant/Kitchen/Blender.visible = true
        
        # Добавляем новые рецепты
        for recipe in equipment[equipment_name]["new_recipes"]:
            if recipe == "Бургер с грилем":
                recipes["Бургер с грилем"] = {"булка": 1, "говяжья котлета": 1, "сыр чеддер": 1, "гриль": 1, "цена": 150}
            elif recipe == "Картошка фри":
                recipes["Картошка фри"] = {"картошка": 1, "цена": 50}
            elif recipe == "Кофе":
                recipes["Кофе"] = {"кофе": 1, "цена": 30}
            elif recipe == "Пицца":
                recipes["Пицца"] = {"тесто": 1, "сыр": 1, "томаты": 1, "цена": 200}
            elif recipe == "Смузи":
                recipes["Смузи"] = {"фрукты": 1, "молоко": 1, "цена": 100}
    else:
        UI.show_message("Оборудование не найдено.")
