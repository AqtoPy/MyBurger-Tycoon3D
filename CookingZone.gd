extends Area3D

var current_recipe = ""
var cooking_progress = 0.0

func _on_body_entered(body):
    if body.name == "Player":
        start_cooking()

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

func spawn_food(recipe):
    var food = preload("res://food.tscn").instantiate()
    food.init(recipe)
    add_child(food)
