# from openai import OpenAI
import json
from os import getenv

# client = OpenAI(api_key=getenv("OPENAI_API_KEY"))

# def schedule_meeting(date, time, attendees):
#     # Connect to calendar service:
#     return { "event_id": "1234", "status": "Meeting scheduled successfully!",
#             "date": date, "time": time, "attendees": attendees }

# OPENAI_FUNCTIONS = {
#     "schedule_meeting": schedule_meeting
# }

# functions = [
#     {
#         "type": "function",
#         "function": {
#             "type": "object",
#             "name": "schedule_meeting",
#             "description": "Set a meeting at a specified date and time for designated attendees",
#             "parameters": {
#                 "type": "object",
#                 "properties": {
#                     "date": {"type": "string", "format": "date"},
#                     "time": {"type": "string", "format": "time"},
#                     "attendees": {"type": "array", "items": {"type": "string"}},
#                 },
#                 "required": ["date", "time", "attendees"],
#             },
#         },
#     }
# ]

from langchain_experimental.llms.ollama_functions import OllamaFunctions
from langchain_core.messages import HumanMessage, AIMessage
# from langchain_core.messages import AIMessage

# model = OllamaFunctions(model="mixtral:8x7b", format="json")

system_prompt = """
You are an travel advisor able to get the user to choose which country they like to visit and can retrieve some information about the given location. Don't assume the country if the user is not able to clearly state one and it matches the list given to you. In this case respond with 'This country is not on the given continent
"""

model = OllamaFunctions(model="llama3.1:latest", format="json", system=system_prompt)

m = model.bind_tools(
    tools=[
        {
            "name": "get_current_weather",
            "description": "Get the current weather in a given location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, " "e.g. San Francisco, CA",
                    },
                    "unit": {
                        "type": "string",
                        "enum": ["celsius", "fahr   enheit"],
                    },
                },
                "required": ["location"],
            },
        },
        {
            "name": "list_countries",
            "description": "Returns a list of major European countries",
            "parameters": {
                "type": "object",
                "properties": {
                    "continent": {
                        "type": "string",
                        "description": "The continent where the travel wishes to visit" "e.g. South America",
                    },
                },
                "required": ["continent"],
            },
        }
    ],
    # function_call={"name": "get_current_weather"},
)

messages = []
# messages.append(AIMessage(content="You are an travel advisor able to get the user to choose which country they like to visit and can retrieve some information about the given location. Don't assume the country if the user is not able to clearly state one and it matches the list given to you. In this case respond with 'This country is not on the given continent'"))

messages.append(HumanMessage(content="I would like to travel to a European Country and I would like to know the current temperature.", usage_metadata=True))

response = m.invoke(messages)

j = json.loads(response.json())

# print(j['tool_calls'][0])
print(j)

# messages.append(AIMessage(
#         content="Czech Republic, France, Germany, Spain",
#         # additional_kwargs={
#         #     "function_call": {
#         #         "name": "list_countries",
#         #         "arguments": "{\"continent\": \"Europe\"}"
#         #     }
#         # },
#     ),
# )

# messages.append(AIMessage(content=response)) #AIMessage
messages.append(AIMessage(content="The list_countries tools has this list of countries: Czech Republic, France, Germany, Spain. Please choose a country"))
# response = m.invoke(messages)
# print(response)

messages.append(HumanMessage(content="I would like to go to Poland", usage_metadata=True))

response = m.invoke(messages)
print(response)

# messages.append(HumanMessage(content="The get_current_weather tool reports the following temperature: \n"+json.dumps({'temperature': '-25'}), usage_metadata=True))
# # messages.append(HumanMessage(content="Results of get_current_weather with location `Prague`: -20 degrees Celsius, Sunny"))

# messages.append(HumanMessage(content="write a nice weather report.", usage_metadata=True))

# print(model.invoke(messages))








# # Start the conversation:
# messages = [
#     {
#         "role": "user",
#         "content": "Schedule a meeting on 2023-11-01 at 14:00 with Alice and Bob.",
#     }
# ]

# # Send the conversation and function schema to the model:
# response = client.chat.completions.create(
#     model="gpt-3.5-turbo-1106",
#     messages=messages,
#     tools=functions,
#     tool_choice="auto"
# )

# response = response.choices[0].message

# # Check if the model wants to call our function:
# if response.tool_calls:
#     # Get the first function call:
#     first_tool_call = response.tool_calls[0]

#     # Find the function name and function args to call:
#     function_name = first_tool_call.function.name
#     function_args = json.loads(first_tool_call.function.arguments)
#     print("This is the function name: ", function_name)
#     print("These are the function arguments: ", function_args)

#     function = OPENAI_FUNCTIONS.get(function_name)

#     if not function:
#         raise Exception(f"Function {function_name} not found.")

#     # Call the function:
#     function_response = function(**function_args)

#     # Share the function's response with the model:
#     messages.append(
#         {
#             "role": "function",
#             "name": "schedule_meeting",
#             "content": json.dumps(function_response),
#         }
#     )

#     # Let the model generate a user-friendly response:
#     second_response = client.chat.completions.create(
#         model="gpt-3.5-turbo-0613", messages=messages
#     )

#     print(second_response.choices[0].message.content)