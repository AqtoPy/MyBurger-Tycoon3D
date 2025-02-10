extends Area3D

var has_cashier = false  # Есть ли кассир

func _on_body_entered(body):
    if body.name == "Player" and GameManager.current_food != "":
        if has_cashier:
            QueueManager.complete_order()
        else:
            UI.show_message("Игрок передал блюдо посетителю!")
            QueueManager.complete_order()
        GameManager.current_food = ""
