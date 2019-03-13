import os
import json
import logging

# import requests

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        Schedule Input Format

        Event doc: https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-scheduledevents-example-use-app-spec.html

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    JSON string
    """

    # try:
    #     ip = requests.get("http://checkip.amazonaws.com/")
    # except requests.RequestException as e:
    #     # Send some context about this error to Lambda Logs
    #     print(e)

    #     raise e

    name = os.getenv("NAME", "world")

    logger.info(event)
    event_input = event.get('event_input', 'event_input_not_found')

    return json.dumps({
        "message": "hello " + name,
        "event_input": event_input,
        # "location": ip.text.replace("\n", "")
    })
