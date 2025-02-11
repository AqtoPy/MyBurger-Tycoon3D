extends Node3D

@export var unlock_price: int = 1000  # Цена разблокировки
@export var recipes: Array[String] = []  # Рецепты для этого оборудования
@export var is_locked: bool = true  # Заблокировано ли оборудование

@onready var equipment_mesh = $EquipmentMesh
@onready var unlock_label = $UnlockPriceLabel
@onready var cooking_zone = $CookingZone
@onready var progress_bar = $ProgressBar

func _ready():
    if is_locked:
        equipment_mesh.visible = false
        unlock_label.text = str(unlock_price) + " руб."
    else:
        unlock_label.visible = false

# Функция разблокировки
func unlock():
    is_locked = false
    equipment_mesh.visible = true
    unlock_label.visible = false
    cooking_zone.monitoring = true  # Активируем зону готовки

# Проверка, можно ли готовить рецепт
func can_cook(recipe_name: String) -> bool:
    return recipe_name in recipes
