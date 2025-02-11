extends Area3D

var is_cooking: bool = false
var current_recipe: String = ""

@onready var progress_bar = $ProgressBar
@onready var timer = $Timer

# Игрок вошёл в зону
func _on_body_entered(body):
    if body.name == "Player" and !is_cooking:
        var selected_recipe = GameManager.selected_recipe
        if get_parent().can_cook(selected_recipe):
            start_cooking(selected_recipe)
        else:
            UI.show_message("Здесь нельзя готовить этот рецепт!")

# Начать готовку
func start_cooking(recipe_name: String):
    is_cooking = true
    current_recipe = recipe_name
    progress_bar.visible = true
    progress_bar.value = 0
    timer.wait_time = GameManager.recipes[recipe_name]["cook_time"]
    timer.start()

# Обновление прогресс-бара
func _process(delta):
    if is_cooking:
        progress_bar.value = (1 - timer.time_left / timer.wait_time) * 100

# Готовка завершена
func _on_timer_timeout():
    is_cooking = false
    progress_bar.visible = false
    spawn_food(current_recipe)

# Создать блюдо
func spawn_food(recipe_name: String):
    var food_scene = load("res://FoodScenes/" + recipe_name + ".tscn")
    var food = food_scene.instantiate()
    get_parent().add_child(food)
    food.global_position = $SpawnPoint.global_position  # Точка спавна блюда
