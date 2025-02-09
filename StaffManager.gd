extends Node

# Список улучшений для работников
var staff_upgrades = {
    "cooking_speed": {"level": 1, "cost": 1000, "effect": 0.1},  # Увеличение скорости приготовления
    "serving_speed": {"level": 1, "cost": 1000, "effect": 0.1},  # Увеличение скорости обслуживания
}

# Функция для улучшения навыков работников
func upgrade_staff(upgrade_name):
    if GameManager.rubles >= staff_upgrades[upgrade_name]["cost"]:
        GameManager.add_rubles(-staff_upgrades[upgrade_name]["cost"])
        staff_upgrades[upgrade_name]["level"] += 1
        staff_upgrades[upgrade_name]["cost"] += 500  # Увеличиваем цену на 500
        UI.show_message("Навык улучшен: " + upgrade_name)
        apply_upgrade(upgrade_name)
    else:
        UI.show_message("Недостаточно рублей!")

# Функция для применения улучшения
func apply_upgrade(upgrade_name):
    match upgrade_name:
        "cooking_speed":
            for worker in GameManager.staff:
                worker.cooking_speed += staff_upgrades[upgrade_name]["effect"]
        "serving_speed":
            for worker in GameManager.staff:
                worker.serving_speed += staff_upgrades[upgrade_name]["effect"]
