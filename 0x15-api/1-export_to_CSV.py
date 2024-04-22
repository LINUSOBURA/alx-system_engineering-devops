#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""
import csv
import json
from sys import argv
from urllib.request import urlopen

if __name__ == "__main__":
    with urlopen(f'https://jsonplaceholder.typicode.com/users/{argv[1]}'
                 ) as response:
        user_json = response.read().decode('utf-8')
        user_list = json.loads(user_json)

        employee = user_list.get('name')
        username = user_list.get('username')

    with urlopen(f'https://jsonplaceholder.typicode.com/todos') as response:
        tasks_json = response.read().decode('utf-8')
        tasks_list = json.loads(tasks_json)

        user_tasks = []
        for task in tasks_list:
            if task.get('userId') == int(argv[1]):
                user_tasks.append(task)

        total_tasks = len(user_tasks)
        completed_tasks = 0
        for task in user_tasks:
            if task.get('completed') is True:
                completed_tasks += 1

        tasks_done = []
        for task in user_tasks:
            if task.get('completed') is True:
                tasks_done.append(task['title'])

    print("""Employee {} is done with tasks({}/{}):""".format(
        employee, completed_tasks, total_tasks))
    for task in tasks_done:
        print(f"\t {task}")

    csv_file_path = argv[1] + ".csv"

    with open(csv_file_path, mode='w', newline='') as csv_file:
        writer = csv.writer(csv_file, quoting=csv.QUOTE_ALL)

        for task in user_tasks:
            task_completed_status = task.get('completed')
            title = task.get('title')
            writer.writerow([argv[1], username, task_completed_status, title])

        csv_file.close()
