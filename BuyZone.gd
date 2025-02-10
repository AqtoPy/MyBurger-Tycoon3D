extends Area3D

@export var item_cost: int  # Стоимость предмета
@export var item_scene: PackedScene  # Сцена предмета

func _on_body_entered(body):
    if body.name == "Player":
        if GameManager.rubles >= item_cost:
            GameManager.add_rubles(-item_cost)
            var item = item_scene.instantiate()
            get_parent().add_child(item)
            UI.show_message("Предмет куплен!")
        else:
            UI.show_message("Недостаточно рублей!")
