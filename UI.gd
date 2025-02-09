extends CanvasLayer

@onready var rubles_label = $RublesLabel
@onready var level_label = $LevelLabel
@onready var message_label = $MessageLabel
@onready var upgrade_list = $UpgradeList
@onready var equipment_list = $EquipmentList

@onready var name_input = $NameInput
@onready var name_button = $NameButton

@onready var recipe_buttons = $RecipeButtons

func update_ui():
    $RublesLabel.text = "Рубли: %d" % GameManager.rubles
    $LevelLabel.text = "Уровень: %d" % GameManager.player_level
    update_recipe_list()

func update_recipe_list():
    $RecipeList.clear()
    for recipe in GameManager.recipes:
        $RecipeList.add_item("%s (%d руб)" % [recipe, GameManager.recipes[recipe].price])

func _on_recipe_selected(index):
    GameManager.selected_recipe = $RecipeList.get_item_text(index).split(" ")[0]

func _on_RecipeButton_pressed(recipe_name):
    CookingZone.start_cooking(recipe_name)

func _on_NameButton_pressed():
    var new_name = name_input.text
    if new_name != "":
        RestaurantName.set_restaurant_name(new_name)

# Функция для обновления рублей
func update_rubles(amount):
    rubles_label.text = "Рублей: " + str(amount)

# Функция для обновления уровня
func update_level(level):
    level_label.text = "Уровень: " + str(level)

# Функция для отображения сообщений
func show_message(message):
    message_label.text = message

# Функция для обновления списка улучшений
func update_upgrade_list(upgrades):
    for child in upgrade_list.get_children():
        child.queue_free()  # Очищаем список
    
    for upgrade in upgrades:
        var upgrade_label = Label.new()
        upgrade_label.text = upgrade + " (Уровень: " + str(upgrades[upgrade]["level"]) + ")"
        upgrade_list.add_child(upgrade_label)

# Функция для обновления списка оборудования
func update_equipment_list(equipment):
    for child in equipment_list.get_children():
        child.queue_free()  # Очищаем список
    
    for item in equipment:
        var equipment_label = Label.new()
        equipment_label.text = item + " (Разблокировано: " + str(equipment[item]["unlocked"]) + ")"
        equipment_list.add_child(equipment_label)

func _on_HireStaffButton_pressed():
    GameManager.hire_staff()
