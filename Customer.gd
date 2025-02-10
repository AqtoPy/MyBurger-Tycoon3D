extends CharacterBody3D

var order = ""  # Текущий заказ
var holding_food = null  # Блюдо в руках

func choose_order():
    var available_recipes = []
    for equipment in GameManager.equipment:
        if equipment.visible:  # Проверяем, доступно ли оборудование
            available_recipes += equipment.recipes
    if available_recipes.size() > 0:
        order = available_recipes[randi() % available_recipes.size()]
        $OrderBubble.show_order(order)
    else:
        queue_free()  # Если нет доступных рецептов, посетитель уходит

func receive_food(food):
    if food == order:
        holding_food = food
        $FoodMesh.visible = true
        pay()
        leave()

func pay():
    GameManager.add_rubles(GameManager.recipes[order]["price"])

func leave():
    await get_tree().create_timer(5).timeout
    queue_free()
