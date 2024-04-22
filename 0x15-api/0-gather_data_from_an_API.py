#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID, returns information about his/her TODO list progress.
"""
import json
from sys import argv
from urllib.request import urlopen

with urlopen(
        f'https://jsonplaceholder.typicode.com/users/{argv[1]}') as response:
    user_json = response.read().decode('utf-8')
    user_list = json.loads(user_json)

    employee = user_list['name']

with urlopen(f'https://jsonplaceholder.typicode.com/todos') as response:
    tasks_json = response.read().decode('utf-8')
    tasks_list = json.loads(tasks_json)

    user_tasks = []
    for task in tasks_list:
        if task['userId'] == int(argv[1]):
            user_tasks.append(task)

    total_tasks = len(user_tasks)
    completed_tasks = 0
    for task in user_tasks:
        if task['completed'] == True:
            completed_tasks += 1

    tasks_done = []
    for task in user_tasks:
        if task['completed'] == True:
            tasks_done.append(task['title'])

#print(user_list['name'])
#print(total_tasks)
#print(completed_tasks)
#print(tasks_done)

print(
    f"""Employee {employee} is done with tasks({completed_tasks}/{total_tasks}):"""
)
for task in tasks_done:
    print(f"\t{task}")
