extends Node

# Название заведения
var restaurant_name = "Моя бургерная"

# Функция для изменения названия
func set_restaurant_name(new_name):
    restaurant_name = new_name
    UI.show_message("Название изменено на: " + restaurant_name)
