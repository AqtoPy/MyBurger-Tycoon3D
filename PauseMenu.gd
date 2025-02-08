extends CanvasLayer

# Функция для продолжения игры
func _on_ResumeButton_pressed():
    get_tree().paused = false
    queue_free()  # Закрываем меню паузы

# Функция для сохранения игры
func _on_SaveButton_pressed():
    SaveManager.save_game()
    UI.show_message("Игра сохранена!")

# Функция для выхода в главное меню
func _on_MainMenuButton_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://StartMenuScene.tscn")
