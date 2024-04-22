#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""
import json
from urllib.request import urlopen

if __name__ == "__main__":

    all_tasks = {}

    with urlopen(f'https://jsonplaceholder.typicode.com/users') as response:
        user_json = response.read().decode('utf-8')
        user_list = json.loads(user_json)

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

                all_tasks[user_id] = task_owned_list

                result_dict = {user_id: all_tasks}

    json_object = json.dumps(result_dict, indent=4)

    json_file_path = 'todo_all_employees.json'
    with open(json_file_path, 'w') as json_file:
        json_file.write(json_object)
