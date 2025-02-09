extends CharacterBody3D

var current_task = null
var efficiency = 1.0

func assign_task(task):
    current_task = task
    $TaskTimer.start(task.time / efficiency)

func _on_task_timer_timeout():
    complete_task()

func complete_task():
    if current_task.type == "cooking":
        spawn_food(current_task.recipe)
    current_task = null

func upgrade():
    efficiency *= 1.2
