extends Node

@export var customer_scene: PackedScene
@export var spawn_interval: float = 10.0

func _ready():
    $Timer.wait_time = spawn_interval
    $Timer.start()

func _on_timer_timeout():
    var customer = customer_scene.instantiate()
    get_parent().add_child(customer)
    QueueManager.add_customer(customer)
