extends Node

# Путь к файлу сохранения
const SAVE_PATH = "user://save_game.dat"

# Функция для сохранения игры
func save_game():
    var save_data = {
        "rubles": GameManager.rubles,
        "player_level": GameManager.player_level,
        "experience": GameManager.experience,
        "experience_to_next_level": GameManager.experience_to_next_level,
        "recipes": GameManager.recipes,
        "equipment": GameManager.equipment,
    }
    
    var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    file.store_var(save_data)
    file.close()
    UI.show_message("Игра сохранена!")

# Функция для загрузки игры
func load_game():
    if FileAccess.file_exists(SAVE_PATH):
        var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
        var save_data = file.get_var()
        file.close()
        
        GameManager.rubles = save_data["rubles"]
        GameManager.player_level = save_data["player_level"]
        GameManager.experience = save_data["experience"]
        GameManager.experience_to_next_level = save_data["experience_to_next_level"]
        GameManager.recipes = save_data["recipes"]
        GameManager.equipment = save_data["equipment"]
        UI.show_message("Игра загружена!")
    else:
        UI.show_message("Сохранение не найдено.")
