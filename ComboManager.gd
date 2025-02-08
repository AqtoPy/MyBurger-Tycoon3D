extends Node

# Список комбо
var combos = {}

# Функция для создания комбо
func create_combo(name, burger, side, drink, price):
    if GameManager.rubles >= price:
        GameManager.add_rubles(-price)
        combos[name] = {"бургер": burger, "гарнир": side, "напиток": drink, "цена": price}
        UI.show_message("Комбо создано: " + name)
    else:
        UI.show_message("Недостаточно рублей!")
