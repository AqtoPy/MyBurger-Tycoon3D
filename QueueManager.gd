extends Node

var queue = []  # Очередь посетителей
var current_customer = null  # Текущий посетитель у кассы

func add_customer(customer):
    queue.append(customer)
    if current_customer == null:
        next_customer()

func next_customer():
    if queue.size() > 0:
        current_customer = queue.pop_front()
        current_customer.choose_order()
    else:
        current_customer = null

func complete_order():
    if current_customer:
        current_customer.receive_food(GameManager.current_food)
        current_customer = null
        next_customer()
