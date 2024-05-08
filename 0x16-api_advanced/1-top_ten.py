#!/usr/bin/python3
"""
Getting subreddit top 10 hot posts
"""
import requests


def top_ten(subreddit):
    """
    Retrieves the top 10 hot posts from a given subreddit.

    Parameters:
        subreddit (str): The name of the subreddit.

    Returns:
        None: If the request fails.
        None: If the response does not contain any data.
        None: If the response does not contain any children.
        None: If the response does not contain any titles.
        None: If the response does not contain any data
        for any of the children.
        None: If the response does not contain any titles
        for any of the children.
        None: If the response does not contain any titles
        for the first 10 children.
        None: If the response does not contain any titles
        for the first 10 children.
    """

    url = f'https://www.reddit.com/r/{subreddit}/hot.json'
    response = requests.get(url)

    if response.status_code != 200:
        print('None')
        return None

    for i in range(10):
        print(response.json().get('data').get('children')[i].get('data').get(
            'title'))

    response.close()
