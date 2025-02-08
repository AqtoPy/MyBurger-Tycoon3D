extends CharacterBody3D

# Статус работника
var is_busy = false

# Функция для приготовления еды
func cook_food(recipe_name):
    if not is_busy:
        is_busy = true
        var cooking_time = GameManager.recipes[recipe_name]["cooking_time"]
        await get_tree().create_timer(cooking_time).timeout  # Имитация приготовления
        is_busy = false
        UI.show_message("Приготовлено: " + recipe_name)
