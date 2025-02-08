extends Node

# Список улучшений
var upgrades = {
    "kitchen_speed": {"level": 1, "cost": 1000, "effect": 0.1},  # Увеличение скорости приготовления
    "staff_efficiency": {"level": 1, "cost": 2000, "effect": 0.2},  # Увеличение эффективности персонала
}

# Функция для покупки улучшения
func buy_upgrade(upgrade_name):
    if GameManager.rubles >= upgrades[upgrade_name]["cost"]:
        GameManager.add_rubles(-upgrades[upgrade_name]["cost"])
        upgrades[upgrade_name]["level"] += 1
        UI.show_message("Улучшение куплено: " + upgrade_name)
        apply_upgrade(upgrade_name)
    else:
        UI.show_message("Недостаточно рублей!")

# Функция для применения улучшения
func apply_upgrade(upgrade_name):
    match upgrade_name:
        "kitchen_speed":
            GameManager.kitchen_speed += upgrades[upgrade_name]["effect"]
            UI.show_message("Скорость кухни увеличена!")
        "staff_efficiency":
            GameManager.staff_efficiency += upgrades[upgrade_name]["effect"]
            UI.show_message("Эффективность персонала увеличена!")
