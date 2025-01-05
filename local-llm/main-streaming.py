import asyncio
from ollama import AsyncClient
from colorama import init, Fore,  Style
from pynput.keyboard import Key, Listener, Controller

# from llm_cost_estimation import count_tokens

text = "Hello, how are you?"
model = "gpt-4"

model = "gemma2:27b"
model = "llama3.1:70b"
model = "qwen2.5:14b-instruct"
model = "llama3.1"
model = "llama3.1:latest"
model = "mistral-nemo:latest"
model = "llama3.1:70b"
model = "qwen2.5:14b-instruct"
model = "mixtral:8x7b"

# I need the story of Snow White in 4000 words.
def withContext():
    async def chat():
        # userInput = """
        # #     I have an idea for a blog post I'd like to write and I need your help with some of the details, formatting and ensuring the text is clear and concise.
        # # """
        # userInput = """
        #     you are a physics expert and a great teacher or quantum physics and you are going to help me understand some quantum physics basics.
        # """
        userInput = """
            you are an expert on construction techniques and materials especially around masonry. 
        """
        userInput = ""

        messages = []

        # context = """
        #     The blog post is attempting to clearly explain the relationship between a HardDrive Sector, Block Size, FileSystem Block Size, memory page size and finally the operation system scheduler.
        #     The intent is to create a simple diagram showing how each bit fits in to the whole flow. The example I'd like to use is a small C, C++ or GoLang app, which will demonstrate the example by writing a small chunk of data to the disk.  With this I would also like to be able to explain about IOPS and latency when it comes to writing data to IO.
        #     I think the title of the post should be "Understanding Hard Drive Sectors, Bloc k Size, and IOPS: A Practical Example"
        #     Please provide an outline and then generate the actual blog post based on the outline.
        # """
        context = """
        """
#         context = """
# One of the fundamental principles of quantum mechanics is that an object can exist in multiple states simultaneously, a phenomenon known as superposition. This statement is very interesting. Can you go into more detail how superposition is possible?    
#         """
#         context = """
# I want to talk about concrete.  I need to pour a concrete slab measuring 1m by 1m and 30cm deep.  I can do it during my summer where the temperature is around 30 degrees Celsius. I can also do it in winter where the temperature is -20 degrees Celsius.  I specifically want to ask what should I add or remove from the concrete mixture between such two different pouring temperatures.   
#         """

        messages.append({
                "role": "user",
                "content": context,
            })

        while userInput != "exit":
            messages.append({
                "role": "user",
                "content": userInput,
            })

            if bytes(userInput, "utf8") == bytes("\x1b", "utf8"): # \x1b - Alt-Enter
                response = ""

                async for part in await AsyncClient().chat(
                    model=model, messages=messages, stream=True, options=dict(num_ctx=2000)
                ):
                    c = part["message"]["content"]
                    print(f'{Fore.CYAN}{c}', end="", flush=True)
                    response = "".join([response, c])

                messages.append({
                    "role": "system",
                    "content": response,
                })
                # Count tokens in the text
                print(f'{Fore.LIGHTYELLOW_EX} \n') 
                # prompt_tokens, estimated_completion_tokens = count_tokens(messages, "gpt-4")

                # print(f"Number of tokens in the prompt: {prompt_tokens}")
                # print(f"Estimated number of tokens in the completion: {estimated_completion_tokens}")
                print(f'{Fore.WHITE}') 

            userInput = input()

    asyncio.run(chat())


if __name__=="__main__": 
    withContext()



    # from llm_cost_estimation import models

    # for model in models:
    #     print(f'Model Name: {model["name"]}')
    #     print(f'Completion Cost Per Token: {model["completion_cost_per_token"]}')
    #     print(f'Prompt Cost Per Token: {model["prompt_cost_per_token"]}')
    #     print(f'Maximum Tokens: {model["max_tokens"]}')
    #     print(f'Description: {model["description"]}\n')








#      Sure, here is a possible outline for your blog post:

# 1. Introduction
#         * Explanation of the purpose of the post and the example app
#         * Brief overview of hard drive sectors, block size, file system block size, memory page size, and IOPS
# 2. Hard Drive Sectors
#         * Definition and explanation of hard drive sectors
#         * Importance of sector size for performance
# 3. Block Size
#         * Definition and explanation of block size
#         * Relation between block size and sector size
#         * Impact on performance (IOPS and latency)
# 4. File System Block Size
#         * Definition and explanation of file system block size
#         * How it relates to block size and sector size
#         * Its role in managing files and directories
# 5. Memory Page Size
#         * Definition and explanation of memory page size
#         * How it relates to block size and file system block size
#         * Its role in virtual memory management
# 6. Operating System Scheduler
#         * Explanation of how the operating system schedules disk I/O operations
#         * Impact on performance (IOPS and latency)
# 7. Practical Example: Writing Data to Disk
#         * Code example of a simple C/C++/Go app that writes data to disk
#         * Measurement of IOPS and latency for the operation
# 8. Conclusion
#         * Summary of the key takeaways from the post
#         * Final thoughts on the importance of understanding these concepts

# And here is the actual blog post based on the outline:

# ---

# Understanding Hard Drive Sectors, Block Size, and IOPS: A Practical Example
# =============================================================================

# In this blog post, we will explore the relationship between hard drive sectors, block size, file system block size, memory page size, and the operating system scheduler. We'll also provide a practical example using a simple C/C++/Go app that writes data to disk, and discuss IOPS and latency in the context of disk I/O operations.

# Introduction
# ------------

# Have you ever wondered how data is stored on a hard drive, or how the operating system manages disk I/O operations? If so, then this blog post is for you! We'll be taking a deep dive into the concepts of hard drive sectors, block size, file system block size, memory page size, and the operating system scheduler. By the end of this post, you should have a clear understanding of how these concepts fit together, and how they impact disk I/O performance.

# To make things more concrete, we'll be providing a practical example using a simple C/C++/Go app that writes data to disk. We'll measure the IOPS (input/output operations per second) and latency of this operation, and discuss how these metrics are affected by the concepts we've covered.

# Hard Drive Sectors
# ------------------

# At a low level, hard drives store data in small units called sectors. A sector is a fixed-size block of data that is physically written to the disk platter. The size of a sector is typically 512 bytes or 4096 bytes, although newer hard drives may use larger sector sizes.

# The sector size is important for performance because it determines how much data can be read or written in a single operation. For example, if the sector size is 512 bytes, then the hard drive can only read or write 512 bytes at a time. This means that if you need to read or write a large amount of data, the hard drive will need to perform multiple operations, which can increase latency and decrease throughput.

# Block Size
# ----------

# In addition to sectors, hard drives also use blocks to manage data storage. A block is a logical unit of data that consists of one or more physical sectors. The size of a block is typically a power of 2, such as 512 bytes, 1024 bytes (1 KiB), 2048 bytes (2 KiB), 4096 bytes (4 KiB), or 8192 bytes (8 KiB).

# The block size is related to the sector size because each block consists of one or more sectors. For example, if the sector size is 512 bytes and the block size is 4096 bytes, then each block consists of 8 sectors.

# The block size has a significant impact on disk I/O performance, as it determines how much data can be read or written in a single operation. Larger blocks can increase throughput because more data can be transferred in each operation, but they also increase latency because more data needs to be read or written.

# File System Block Size
# ---------------------

# The file system also uses blocks to manage data storage, but at a higher level than the hard drive. The file system block size is the smallest unit of data that can be read or written by the file system. Like hard drive blocks, the file system block size is typically a power of 2, such as 512 bytes, 1024 bytes (1 KiB), 2048 bytes (2 KiB), 4096 bytes (4 KiB), or 8192 bytes (8 KiB).

# The file system block size is related to the hard drive block size because the file system uses the hard drive blocks to store its own blocks. For example, if the file system block size is 4096 bytes and the hard drive block size is also 4096 bytes, then each file system block can be stored in a single hard drive block.

# The file system block size has an impact on disk I/O performance because it determines how much data can be read or written by the file system in a single operation. Larger blocks can increase throughput because more data can be transferred in each operation, but they also increase latency because more data needs to be read or written.

# Memory Page Size
# ----------------

# In addition to hard drive blocks and file system blocks, the operating system also uses memory pages to manage virtual memory. A memory page is a fixed-size block of memory that is used to store data in virtual memory. The size of a memory page is typically 4096 bytes (4 KiB) or 8192 bytes (8