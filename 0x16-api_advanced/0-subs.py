#!/usr/bin/python3
"""
Getting Subreddit subscriber count
"""
import requests


def number_of_subscribers(subreddit):
    """
    Retrieves the number of subscribers for a given subreddit.

    Parameters:
        subreddit (str): The name of the subreddit.

    Returns:
        int: The number of subscribers for the subreddit.
        Returns 0 if the request fails.
    """
    url = f'https://www.reddit.com//r/{subreddit}/about.json'
    response = requests.get(url)
    if not response:
        return 0
    response = response.json().get('data').get('subscribers')
    return (response)
