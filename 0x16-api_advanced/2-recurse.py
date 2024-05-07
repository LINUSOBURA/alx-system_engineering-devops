#!/usr/bin/python3
"""
Recursively retrieves the hot posts from a given subreddit
and returns a list of the titles."""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Recursively retrieves the hot posts from a given subreddit
    and returns a list of the titles.

    Parameters:
        subreddit (str): The name of the subreddit.
        hot_list (list, optional): A list to store the titles of the
        hot posts. Defaults to an empty list.
        after (str, optional): The 'after' parameter for pagination.
        Defaults to None.

    Returns:
        list: A list of the titles of the hot posts from the subreddit.
        Returns None if the request fails or if there are no hot posts.
    """
    url = f'https://www.reddit.com/r/{subreddit}/hot.json'
    params = {'limit': 100}

    if after:
        params['after'] = after

    response = requests.get(url, params=params)

    if response.status_code != 200:
        return None

    data = response.json()

    if 'error' in data:
        return None

    for post in data['data']['children']:
        hot_list.append(post['data']['title'])

    after = data['data'].get('after')
    if after:
        return recurse(subreddit, hot_list, after)
    else:
        if hot_list:
            return hot_list
        else:
            return None
