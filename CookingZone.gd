extends Area3D

var current_recipe = ""
var cooking_progress = 0.0

@onready var equipment = get_parent()  # Ссылка на оборудование

func _on_body_entered(body):
    if body.name == "Player":
        if equipment.can_cook(GameManager.selected_recipe):
            start_cooking(GameManager.selected_recipe)
        else:
            UI.show_message("Это оборудование не подходит для выбранного рецепта!")

func start_cooking():
    var recipe = GameManager.selected_recipe
    if recipe:
        current_recipe = recipe
        $ProgressBar.visible = true
        $Timer.start(recipe.cook_time)

func _on_timer_timeout():
    spawn_food(current_recipe)
    current_recipe = ""
    $ProgressBar.visible = false

func spawn_food(recipe_name):
    var food_scene = load("res://FoodScenes/" + recipe_name + ".tscn")
    var food_instance = food_scene.instantiate()
    add_child(food_instance)
    
    # Передаём еду посетителю
    var customer = get_nearest_customer()
    if customer:
        customer.receive_food(recipe_name)

func get_nearest_customer():
    var customers = get_tree().get_nodes_in_group("customers")
    if customers.size() > 0:
        return customers[0]  # Возвращаем первого посетителя
    return null
