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
    with urlopen(f'https://jsonplaceholder.typicode.com/users') as response:
        user_json = response.read().decode('utf-8')
        user_list = json.loads(user_json)

        result_dict_list = []

        for user in user_list:
            employee = user['name']
            username = user['username']
            user_id = user['id']

            with urlopen(
                    f'https://jsonplaceholder.typicode.com/todos') as response:
                tasks_json = response.read().decode('utf-8')
                tasks_list = json.loads(tasks_json)

                user_tasks = []
                for task in tasks_list:
                    if task.get('userId') == user['id']:
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

                task_owned_list = []
                for task in user_tasks:
                    task_completed_status = task.get('completed')
                    title = task.get('title')
                    tasks_owned_dict = {
                        "username": username,
                        "task": title,
                        "completed": task_completed_status
                    }
                    task_owned_list.append(tasks_owned_dict)

                result_dict_list.append({user_id: task_owned_list})

    json_file_path = 'todo_all_employees.json'
    json_object = json.dumps(result_dict_list, indent=4)

    with open(json_file_path, 'w') as json_file:
        json_file.write(json_object)
