extends Node

# Список миссий
var missions = {
    "sell_100_burgers": {"description": "Продать 100 бургеров", "target": 100, "reward": {"rubles": 1000}, "completed": false},
    "earn_10000_rubles": {"description": "Заработать 10 000 рублей", "target": 10000, "reward": {"rubles": 5000}, "completed": false},
}

# Прогресс миссий
var mission_progress = {
    "burgers_sold": 0,
    "rubles_earned": 0,
}

# Функция для обновления прогресса
func update_progress(mission_type, amount):
    match mission_type:
        "burgers_sold":
            mission_progress["burgers_sold"] += amount
        "rubles_earned":
            mission_progress["rubles_earned"] += amount
    
    check_missions()

# Функция для проверки миссий
func check_missions():
    for mission in missions:
        if not missions[mission]["completed"]:
            match mission:
                "sell_100_burgers":
                    if mission_progress["burgers_sold"] >= missions[mission]["target"]:
                        complete_mission(mission)
                "earn_10000_rubles":
                    if mission_progress["rubles_earned"] >= missions[mission]["target"]:
                        complete_mission(mission)

# Функция для завершения миссии
func complete_mission(mission):
    missions[mission]["completed"] = true
    GameManager.add_rubles(missions[mission]["reward"]["rubles"])
    UI.show_message("Миссия выполнена: " + missions[mission]["description"])
