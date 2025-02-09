extends CharacterBody3D

# Выбранное блюдо
var chosen_food = ""

# Функция для выбора блюда
func choose_food():
    var available_foods = GameManager.recipes.keys()
    chosen_food = available_foods[randi() % available_foods.size()]
    print("Клиент выбрал: ", chosen_food)
    return chosen_food

# Функция для оплаты и получения блюда
func pay_and_receive_food():
    var food_price = GameManager.recipes[chosen_food]["цена"]
    GameManager.add_rubles(food_price)  # Добавляем рубли
    GameManager.add_experience(10)  # Добавляем опыт
    UI.show_message("Клиент заплатил: " + str(food_price) + " рублей")
    
    # Добавляем блюдо в руки
    var food_scene = load("res://FoodScenes/" + chosen_food + ".tscn")
    var food_instance = food_scene.instantiate()
    add_child(food_instance)
    
    # Клиент уходит или садится
    if randi() % 2 == 0:
        walk_out()
    else:
        sit_down()

# Функция для ухода
func walk_out():
    UI.show_message("Клиент уходит с блюдом.")
    queue_free()  # Удаляем посетителя

# Функция для сидения
func sit_down():
    UI.show_message("Клиент садится за стол.")
    await get_tree().create_timer(10).timeout  # Имитация сидения
    queue_free()  # Удаляем посетителя
