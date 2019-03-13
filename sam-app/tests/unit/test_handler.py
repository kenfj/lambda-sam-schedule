import json

import pytest

from src import app


@pytest.fixture()
def schedule_event():
    """Generates Schedule Event using Constant (JSON text)"""

    return {
        "event_input": "something"
    }


def test_lambda_handler(schedule_event, mocker):

    ret = app.lambda_handler(schedule_event, "")
    data = json.loads(ret)

    assert "message" in data
    assert data["message"] == "hello world"

    assert "event_input" in data
    assert data["event_input"] == "something"

    # assert "location" in data.dict_keys()
