import http.client
import json
import asyncio
from ollama import AsyncClient
from colorama import init, Fore,  Style

from llama_index.core import Settings



def fetchReviews():
    model = "llama3:8b"
    model = "llama3.1"
    model = "qwen2.5:14b-instruct"
    model = "llama31-7b-16k"
    # model = "gemma2:27b"

        # conn = http.client.HTTPSConnection("apidojo-booking-v1.p.rapidapi.com")

    # headers = {
    #     'x-rapidapi-key': "b2976d0bf0msh1586eac0f0fbb64p1524b6jsn9a2dfed236a7",
    #     'x-rapidapi-host': "apidojo-booking-v1.p.rapidapi.com"
    # }

    # conn.request("GET", "/reviews/list?languagecode=en-us&user_sort=sort_recent_desc&rows=25&offset=0&filter_language=en%2Cnl&hotel_ids=252498&filter_customer_type=couple%2Cfamily_with_children", headers=headers)

    # res = conn.getresponse()
    # # data = res.read()
    # data = res.read()

    # reviews_json = json.loads(data.decode("utf-8"))

    json_file = open("reviews.json", "r")

    reviews_json = json.load(json_file)

    count = reviews_json['count']
    print(f"count: {count}")

    results = reviews_json['result']
    print(f'results: {len(results)}')
    
    # maximum input size to the LLM
    # Settings.context_window = 4096

    noise_response = 'the street noise is out of our control. Consider bringing ear plugs'
    no_list_response = 'the hotel is located in a historical building without the possibility of installing an elevator which is clearly stated in our hotels description.'

    for review in results:
        title = review['title']
        pros = review['pros']
        cons = review['cons']
        author_name = review['author']['name']
        review_id = review['review_id']

        language_code = review['languagecode']

        language = 'Czech' if language_code.startswith('cz') else 'English'

        async def generate():
            userInput = ""
            context = f"""
    <|begin_of_text|>
    <|start_header_id|>system<|end_header_id|>

    You are an small hotel owner and an expert in responding to hotel reviews. 
    When you see that the review complains about noise then mention: " {noise_response} " in your response. 
    When you see the review complain about the lack of an elevator then mention " {no_list_response} " in the response.
    <|eot_id|>

    <|start_header_id|>user<|end_header_id|>
    The title of my review is: {title}
    <|eot_id|>

    <|start_header_id|>user<|end_header_id|>
    What are the disadvantages?
    <|eot_id|>

    <|start_header_id|>assistant<|end_header_id|>
    {cons}
    <|eot_id|>

    <|start_header_id|>user<|end_header_id|>
    What are the advantages?
    <|eot_id|>

    <|start_header_id|>assistant<|end_header_id|>
    {pros}
    <|eot_id|>

    <|start_header_id|>user<|end_header_id|>
    Write a positive response in {language}. At least 300 words, maximum 500. Start with "Dear {author_name} - {review_id}". Make sure to thank the customer and wish them they had a happy stay. Sign the comment with "Ales Blaha - Hotel Director"
    <|eot_id|>

    <|start_header_id|>assistant<|end_header_id|>
    
    """
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

            print(f'{Fore.WHITE} \n cons: {cons} \n pros: {pros}')
            print(f'{Fore.WHITE} \n-----------------------------------------\n')
        asyncio.run(generate())
