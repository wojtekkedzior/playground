# load the large language model file
# from llama_cpp import Llama
import time
# import torch
import requests
import json
import sys
import hotel
import sql
import agent
from colorama import init, Fore,  Style

from langchain_core.prompts import PromptTemplate
import contexts

import asyncio
from langchain_community.document_loaders import PyPDFLoader
from ollama import AsyncClient
# from llama_cpp.llama_cpp import _load_shared_library

model = "llama3-chatqa"
# model = "llama3:70b"
# model = "tinyllama"
# model = "llama3:8b"
# model = "mixtral:8x7b" #28 GB
model = "mistral " #7 GB
# model = "phi3:14b"
model = "llama3.1"
# model = "llama3:70b"
# model = "gemma2:27b"
# model = "starcoder2:instruct"
# model = "koesn/llama3-8b-instruct"
# model = "llama31-7b-16k"
# model = "qwen2.5:14b-instruct"

# from llm_cost_estimation import count_tokens

def summarise():
    pdf_file = open("/media/wojtek/storage/wojtek/Books/kube/9781492073932_02029802USEN.pdf", "r")

    pdf_loader = PyPDFLoader("/media/wojtek/storage/wojtek/Books/kube/9781492073932_02029802USEN.pdf")
    pages = pdf_loader.load_and_split()
    content = ""

    for p in pages:
        content = "".join([content, p.page_content])

    async def generate(content):
            prompt = """Write a detailed summary of every chapter of the following text delimited by triple backquotes. At least 1000 words per chapter."""
            
            prompt = "".join([prompt, "\n ```"])
            prompt = "".join([prompt, content])
            prompt = "".join([prompt, "```\n"])
            prompt = "".join([prompt, "SUMMARY:"])

            # prompt_template = """Write a concise summary of the following text delimited by triple backquotes.
            #   Return your response in bullet points which covers the key points of the text.
            #   ```{text}```
            #   BULLET POINT SUMMARY:
            #     """
            
            # prompt = PromptTemplate(template=prompt_template)
            # prompt.format(text=content)

            userInput = ""
            while userInput != "exit":
                async for part in await AsyncClient().generate(
                    model=model, prompt=prompt, stream=True, options=dict(num_ctx=45000)
                ):
                    c = part["response"]
                    print(f'{Fore.CYAN}{c}', end="", flush=True)

                print(f'{Fore.WHITE} \n')
                

                # prompt_tokens, estimated_completion_tokens = count_tokens(prompt, "gpt-4")

                # print(f"Number of tokens in the prompt: {prompt_tokens}")
                # print(f"Estimated number of tokens in the completion: {estimated_completion_tokens}")
                print(f'{Fore.WHITE}') 

                userInput = input()
    asyncio.run(generate(content))

def sequential():
    userInput = """
    {
  "task": "SQL Query Analysis",
  "question": "give me a recipe for a chicken vindaloo",
  "instructions": {
    "1_intent_identification": [
      "Identify all ANSI SQL-based retrieval intents present in the question.",
      "Use only the standard intents from the list provided in the 'reference' section.",
      "Focus on ANSI SQL retrieval operations (e.g., selection, filtering, sorting, grouping)."
    ],
    "2_intent_description": [
      "For each identified intent:",
      "a) Provide a brief description of how it applies to the question.",
      "b) Assign a confidence score (0 to 1) based on the scoring guidelines.",
      "c) Explain the rationale for the assigned confidence score."
    ],
    "3_non_sql_aspects": [
      "Identify any non-retrieval intents or actions not achievable with ANSI SQL retrieval.",
      "Describe each non-retrieval aspect and its relevance to the question.",
      "Summarize any challenges related to SQL retrieval implementation, optimization, or performance."
    ]
  },
  "reference": {
    "standard_intents": [
      "Data Selection", "Data Source", "Filtering Data", "Sorting Results",
      "Grouping and Aggregation", "Joining Tables", "Set Operations",
      "Subqueries", "Data and Comparison Operations", "Null Handling",
      "Date and Time Operations"
    ],
    "confidence_scoring": {
      "factors": [
        "Presence of key SQL keywords associated with the intent",
        "Clarity and explicitness of the intent in the question",
        "Consistency with other identified intents",
        "Complexity of the question relative to the intent"
      ],
      "scale": {
        "0.9-1.0": "Very High Confidence (Clear and explicit presence of intent)",
        "0.7-0.89": "High Confidence (Strong indicators of intent)",
        "0.5-0.69": "Medium Confidence (Probable intent, some ambiguity)",
        "0.3-0.49": "Low Confidence (Possible intent, significant ambiguity)",
        "0-0.29": "Very Low Confidence (Minimal indicators, highly uncertain)"
      }
    }
  }
}
"""
    context = ""

    while userInput != "exit":
        context = "".join([context, " Question: "])
        context = "".join([context, userInput])
        context = "".join([context, "\n"])
        context = "".join([context, " Answer: "])

        # num_ctx = 8096
        num_ctx = 1024
 
        before = time.perf_counter()
        res = requests.post('http://localhost:11434/api/generate', data=json.dumps({  
            "model": model,  
            "prompt": context,  
            "stream": False,
            "options":{
            "num_thread": 4,
            "num_ctx": num_ctx,
            }
        }))
        after = time.perf_counter()

        print(f'{Fore.CYAN} {res.json()["response"]}')

        context = "".join([context, res.json()["response"]])
        context = "".join([context, "\n"])

        calculateTokenPerSec(after - before, res.json()["eval_count"], res.json()["eval_duration"], len(context))

        userInput = input()

def calculateTokenPerSec(duration, evalCount, evalDuration, contextSize):
    print(f'{Fore.WHITE} End of response from the LLM responded in: {duration:0.4f} seconds at a rate of {float(float(evalCount) / float(evalDuration)) * 1000000000} tokens/sec. Context size: {contextSize}" \n')

def starCode():
    run("""
You are a helpful assistant. Execute a logical operation: If you're asked anything about properties, only return the list of properties.
Use the properties from the following text: "xyz"
    """, "")

def generateWithContext():
    run(contexts.TRAVEL, "")

def web():
    run(contexts.WEBSITE, "")

def intro():
    run(contexts.PERSONAL_INFO, "")

def properties():
    run(contexts.TEXT_PARSER, "")

def run(context, userInput):
    async def generate(context, userInput):
        while userInput != "exit":
            response = ""

            context = "".join([context, "<|start_header_id|>user<|end_header_id|>\n"])
            context = "".join([context, userInput])
            context = "".join([context, "<|start_header_id|>assistant<|end_header_id|>\n"])

            async for part in await AsyncClient().generate(
                model=model, prompt=context, stream=True
            ):
                c = part["response"]
                print(f'{Fore.CYAN}{c}', end="", flush=True)
                response = "".join([response, c])

            context = "".join([context, response])

            print(f'{Fore.WHITE} \n')
            userInput = input()

    asyncio.run(generate(context, userInput))

if __name__=="__main__": 
    if sys.argv[1] == "seq":
        sequential()
    elif sys.argv[1] == "gen":
        generateWithContext()
    elif sys.argv[1] == "star":
        starCode()
    elif sys.argv[1] == "sum":
        summarise()
    elif sys.argv[1] == "hotel":
        hotel.fetchReviews()
    elif sys.argv[1] == "web":
        web()
    elif sys.argv[1] == "intro":
        intro()
    elif sys.argv[1] == "sql":
        sql.sql()
    elif sys.argv[1] == "props":
        properties()
    elif sys.argv[1] == "agent":
        agent.agent()



# source my_env/bin/activate
# my_env/bin/python -m pip install -r requirements.txt
# my_env/bin/python main.py gen