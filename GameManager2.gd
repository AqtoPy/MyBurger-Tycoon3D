extends Node

# Основные параметры
var rubles = 0
var player_level = 1
var experience = 0
var experience_to_next_level = 100

# Выбранный рецепт
var selected_recipe = null  # Добавьте эту строку

# Рецепты (20 штук)
var recipes = {
    # Бургеры
    "Классический бургер": {"ingredients": ["булка", "котлета"], "price": 100, "cook_time": 5},
    "Чизбургер": {"ingredients": ["булка", "котлета", "сыр"], "price": 120, "cook_time": 6},
    "Бекон бургер": {"ingredients": ["булка", "котлета", "бекон"], "price": 150, "cook_time": 7},
    
    # Курица
    "Чикенбургер": {"ingredients": ["булка", "курица"], "price": 110, "cook_time": 6},
    "Острый чикен": {"ingredients": ["булка", "курица", "соус"], "price": 130, "cook_time": 7},
    
    # Веганские
    "Веган бургер": {"ingredients": ["булка", "тофу"], "price": 120, "cook_time": 6},
    "Грибной бургер": {"ingredients": ["булка", "грибы"], "price": 140, "cook_time": 7},
    
    # Картофель
    "Картошка фри": {"ingredients": ["картофель"], "price": 60, "cook_time": 4},
    "Сырный картофель": {"ingredients": ["картофель", "сыр"], "price": 80, "cook_time": 5},
    
    # Напитки
    "Кола": {"ingredients": ["сироп"], "price": 50, "cook_time": 2},
    "Смузи": {"ingredients": ["ягоды", "йогурт"], "price": 90, "cook_time": 4},
    
    # Десерты
    "Чизкейк": {"ingredients": ["тесто", "сыр"], "price": 120, "cook_time": 8},
    "Пончик": {"ingredients": ["тесто", "глазурь"], "price": 70, "cook_time": 5},
    
    # Пицца
    "Маргарита": {"ingredients": ["тесто", "сыр", "томаты"], "price": 180, "cook_time": 10},
    "Пепперони": {"ingredients": ["тесто", "колбаса", "сыр"], "price": 200, "cook_time": 12},
    
    # Азиатская кухня
    "Суши": {"ingredients": ["рис", "рыба"], "price": 150, "cook_time": 8},
    "Роллы": {"ingredients": ["рис", "овощи"], "price": 170, "cook_time": 9},
    
    # Завтраки
    "Омлет": {"ingredients": ["яйца", "овощи"], "price": 90, "cook_time": 5},
    "Блинчики": {"ingredients": ["тесто", "джем"], "price": 80, "cook_time": 6},
    
    # Экзотика
    "Тако": {"ingredients": ["лепешка", "мясо", "салат"], "price": 140, "cook_time": 7},
    "Кебаб": {"ingredients": ["лаваш", "мясо", "соус"], "price": 160, "cook_time": 8}
}

# Оборудование
var equipment = {
    "grill": {"unlocked": false, "recipes": ["Классический бургер", "Чизбургер"]},
    "fryer": {"unlocked": false, "recipes": ["Картошка фри"]},
    "coffee_machine": {"unlocked": false, "recipes": ["Смузи"]}
}

# Персонал
var staff = []
var staff_upgrade_cost = 1000

func add_rubles(amount):
    rubles += amount
    UI.update_ui()

func hire_staff():
    if rubles >= staff_upgrade_cost:
        staff.append({"speed": 1.0, "level": 1})
        rubles -= staff_upgrade_cost
        staff_upgrade_cost += 500
        UI.show_message("Новый сотрудник нанят!")

func unlock_equipment(name):
    equipment[name].unlocked = true
    UI.update_equipment_list()
