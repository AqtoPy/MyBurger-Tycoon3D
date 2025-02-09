extends CharacterBody3D

var order = []
var holding_food = null

func choose_order():
    var recipes = GameManager.recipes.keys()
    order = recipes[randi() % recipes.size()]
    $OrderBubble.show_order(order)

func receive_food(food):
    if food == order:
        holding_food = food
        $FoodMesh.visible = true
        pay()
        leave()

func pay():
    GameManager.add_rubles(GameManager.recipes[order].price)

func leave():
    await get_tree().create_timer(5).timeout
    queue_free()
