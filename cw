#!/usr/bin/python3
import os
import sys
import logging
from openai import OpenAI

# Configure logging
logging.basicConfig(level=logging.ERROR)
logger = logging.getLogger(__name__)

# Read the API key from the environment variable
api_key = os.getenv("OPENAI_API_KEY")
if api_key is None:
    logger.error("API key not found, please set the environment variable OPENAI_API_KEY")
    sys.exit(1)

# Base URL and model name
BASE_URL = "https://openrouter.ai/api/v1"
MODEL = "openai/gpt-4o-mini"

# Initialize client
client = OpenAI(api_key=api_key, base_url=BASE_URL)

def get_chat_completion(messages: list, model: str = MODEL) -> str:
    """
    Call the chat completion API with a given list of messages and return the generated response content.
    """
    try:
        response = client.chat.completions.create(
            model=model,
            messages=messages,
            temperature=0,
        )
        return response.choices[0].message.content
    except Exception as e:
        logger.error(f"Error calling chat completion API: {e}")
        sys.exit(1)

def get_answer(query: str) -> str:
    """
    Generate a shell command based on the given problem description. 
    The returned string should contain ONLY the shell command.
    """
    prompt = f"give a shell command that can solve the following problem: {query}, return ONLY the shell command"
    messages = [{"role": "user", "content": prompt}]
    return get_chat_completion(messages)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        logger.error("Usage: {} [Problem Description]".format(sys.argv[0]))
        sys.exit(1)

    query = " ".join(sys.argv[1:])
    command = get_answer(query)
    print(command)
