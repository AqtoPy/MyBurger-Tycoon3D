extends Area3D

@export var recipes: Array[String]  # Рецепты, которые можно готовить на этом оборудовании
@export var equipment_name: String  # Название оборудования

func _ready():
    visible = false  # Оборудование изначально невидимо

func unlock():
    visible = true  # Делаем оборудование видимым
    $CookingZone.enabled = true  # Активируем зону готовки

func can_cook(recipe_name):
    return recipe_name in recipes  # Проверяем, можно ли готовить этот рецепт
