extends CanvasLayer

# Функция для начала игры
func _on_StartButton_pressed():
    get_tree().change_scene_to_file("res://MainScene.tscn")

# Функция для выхода из игры
func _on_ExitButton_pressed():
    get_tree().quit()
