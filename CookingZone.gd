extends Area3D

# Текущее блюдо
var current_recipe = ""

# Функция для начала приготовления
func start_cooking(recipe_name):
    if current_recipe == "":
        current_recipe = recipe_name
        UI.show_message("Начато приготовление: " + recipe_name)
        await get_tree().create_timer(5).timeout  # Имитация приготовления
        UI.show_message("Приготовлено: " + recipe_name)
        spawn_food(recipe_name)  # Создаём готовое блюдо
        current_recipe = ""

# Функция для создания готового блюда
func spawn_food(recipe_name):
    var food_scene = load("res://FoodScenes/" + recipe_name + ".tscn")  # Загружаем сцену блюда
    var food_instance = food_scene.instantiate()
    add_child(food_instance)
