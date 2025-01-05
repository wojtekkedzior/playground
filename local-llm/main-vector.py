from pymilvus import MilvusClient

from pymilvus import connections, db

import nltk

conn = connections.connect(host="127.0.0.1", port=19530)

from langchain_community.document_loaders import PyPDFLoader


from pymilvus import CollectionSchema, FieldSchema
from pymilvus import Collection
from pymilvus import connections
from pymilvus import DataType
from pymilvus import Partition
from pymilvus import utility

db.using_database("my_database")

conn = connections.connect(
    host="127.0.0.1",
    port="19530",
    db_name="my_database"
)
print(db.list_database())

client = MilvusClient(
    uri="http://localhost:19530"
)

# client.drop_collection(collection_name="quick_setup")

client.create_collection(
    collection_name="quick_setup",
    dimension=384,
    metric_type="IP",
    max_length=131070
)

#  {"id": i, "vector": vectors[i], "text": queries[i], "subject": "history"}

# dim = 768
# int64_field = FieldSchema(name="int64", dtype=DataType.INT64, is_primary=True)
# float_vector = FieldSchema(name="float_vector", dtype=DataType.FLOAT_VECTOR, dim=dim)
# schema = CollectionSchema(fields=[int64_field, float_vector], enable_dynamic_field=True)
# connections.connect()
# collection = Collection("quick_setup", schema=schema)

# 2. Create a collection
# client.create_collection(collection, dimension=768)

# nb=1000
# import random
# rng = np.random.default_rng(seed=19530)

# rows = [{"int64": i, "float_vector": rng.random((1, dim))[0], "float_vector0": rng.random((1, dim))[0]} for  i in range(0, nb)]
# res = collection.insert(rows)

# data=[
#     {"id": 0, "vector": [0.3580376395471989, -0.6023495712049978, 0.18414012509913835, -0.26286205330961354, 0.9029438446296592], "color": "pink_8682"},
#     {"id": 1, "vector": [0.19886812562848388, 0.06023560599112088, 0.6976963061752597, 0.2614474506242501, 0.838729485096104], "color": "red_7025"},
#     {"id": 2, "vector": [0.43742130801983836, -0.5597502546264526, 0.6457887650909682, 0.7894058910881185, 0.20785793220625592], "color": "orange_6781"},
#     {"id": 3, "vector": [0.3172005263489739, 0.9719044792798428, -0.36981146090600725, -0.4860894583077995, 0.95791889146345], "color": "pink_9298"},
#     {"id": 4, "vector": [0.4452349528804562, -0.8757026943054742, 0.8220779437047674, 0.46406290649483184, 0.30337481143159106], "color": "red_4794"},
#     {"id": 5, "vector": [0.985825131989184, -0.8144651566660419, 0.6299267002202009, 0.1206906911183383, -0.1446277761879955], "color": "yellow_4222"},
#     {"id": 6, "vector": [0.8371977790571115, -0.015764369584852833, -0.31062937026679327, -0.562666951622192, -0.8984947637863987], "color": "red_9392"},
#     {"id": 7, "vector": [-0.33445148015177995, -0.2567135004164067, 0.8987539745369246, 0.9402995886420709, 0.5378064918413052], "color": "grey_8510"},
#     {"id": 8, "vector": [0.39524717779832685, 0.4000257286739164, -0.5890507376891594, -0.8650502298996872, -0.6140360785406336], "color": "white_9381"},
#     {"id": 9, "vector": [0.5718280481994695, 0.24070317428066512, -0.3737913482606834, -0.06726932177492717, -0.6980531615588608], "color": "purple_4976"}
# ]

# res = client.insert(
#     collection_name="quick_setup_two",
#     data=data
# )

from gensim.models import Word2Vec

# pdf_file = open("/media/wojtek/storage/wojtek/Books/kube/9781492073932_02029802USEN.pdf", "r")
# pdf_loader = PyPDFLoader("/media/wojtek/storage/wojtek/Books/kube/9781492073932_02029802USEN.pdf")
# pdf_loader = PyPDFLoader("/media/wojtek/storage/wojtek/Books/JavaScript Step by Step, 3rd Edition.pdf")
# pages = pdf_loader.load_and_split()

import os

list_of_files = {}
for (dirpath, dirnames, filenames) in os.walk("/home/wojtek/git/pdfs"):
    for filename in filenames:
        if filename.endswith('.pdf'): 
            # print(filename)
            list_of_files[filename] = os.sep.join([dirpath, filename])

content = []

print(len(list_of_files))

# for x, res in enumerate(lst): 
#     print (x,":",res) 

# from sentence_transformers import SentenceTransformer
from langchain_text_splitters.sentence_transformers import SentenceTransformersTokenTextSplitter
from pymilvus import model

# langchain_text_splitters.sentence_transformers.SentenceTransformersTokenTextSplitter

sentence_spliter = SentenceTransformersTokenTextSplitter.from_tiktoken_encoder(
     chunk_size=100, chunk_overlap=20,
)

embedding_fn = model.dense.SentenceTransformerEmbeddingFunction(
    # model_name="all-MiniLM-L6-v2", # Specify the model name
    device="cuda:0" # Specify the device to use, e.g., 'cpu' or 'cuda:0'
)

i = 0
            
for file in list_of_files:
    if i < 100:
        print(f'{i} - starting with: {file} ')
        pdf_loader = PyPDFLoader("/home/wojtek/git/pdfs/"+file)
        pages = pdf_loader.load_and_split()
        for p in pages:
            content.append(p.page_content)

        c = ''.join(content)
        chunks = sentence_spliter.split_text(c)
        # print(len(chunks))

        vectors = embedding_fn.encode_documents(chunks)

        data = [
            {"id": i, "vector": vectors[0], "text": chunks[0], "subject": "history"}
        ]

        # print("Data has", len(data), "entities, each with fields: ", data[0].keys())
        # print("Vector dim:", len(data[0]["vector"]))

        res = client.insert(
            collection_name="quick_setup",
            data=data
        )

        print(f'{i} - done with: {file} chunks: {len(chunks)} ')

        i=i+1

# queries = [
#     "Show me the 3 eldest athletes in every event through connecting to the competition for the specified tournament",
#     "In each event, reveal the 3 oldest athletes by linking to the competition of the designated tournament",
#     "By accessing the competition data, display the 3 oldest athletes in each contest for the tournament provided",
#     "Get the names of the 3 oldest athletes in every event on the competition platform for the given tournament",
#     "Joining the competition's database, exhibit the 3 senior-most athletes in all events for the tournament specified",
#     "Using the competition link, show the 3 oldest competitors in each activity for the tournament given",
#     "Through the connection to the rivalry, reveal the 3 oldest participants in every category for the tournament indicated",
#     "By interfacing with the competition's system, display the 3 oldest athletes in each event for the tournament provided",
#     "Accessing the competition details, expose the 3 senior-most competitors in all events for the given tournament",
#     "Through linking to the competitive data, present the 3 eldest athletes in every discipline for the tournament specified",
# ]

# for q in queries:
#     # content.append(p.page_content)
#     words = nltk.word_tokenize(q)
#     content.append(words)
#     # print(len(words))

# from langchain.text_splitter import RecursiveCharacterTextSplitter

# text_splitter = RecursiveCharacterTextSplitter.from_tiktoken_encoder(
#     chunk_size=10, chunk_overlap=5, separators=['.']
# )

# c = ''.join(content)
# chunks = text_splitter.split_text(c)
# print(len(chunks))

# model = SentenceTransformer("all-MiniLM-L6-v2")
# model.encode

# The sentences to encode
# sentences = [
#     "The weather is lovely today.",
#     "It's so sunny outside!",
#     "He drove to the stadium.",
# ]

# from pymilvus import model

# embedding_fn = model.DefaultEmbeddingFunction()
# embedding_fn = model.dense.SentenceTransformerEmbeddingFunction(
#     model_name="all-MiniLM-L6-v2", # Specify the model name
#     device="cuda:0" # Specify the device to use, e.g., 'cpu' or 'cuda:0'
# )

# res = client.insert(
#     collection_name="quick_setup",
#     data=data
# )

i = 0
for v in vectors:
    data = [
        {"id": i, "vector": v, "text": chunks[i], "subject": "history"}
    ]

    res = client.insert(
        collection_name="quick_setup",
        data=data
    )
    i=i+1

# embeddings = model.encode(queries)
# print(embeddings.shape)
# # [3, 384]

# # 3. Calculate the embedding similarities
# similarities = model.similarity(embeddings, embeddings)
# print(similarities)

# model.save("test-model.model")

# print(model)

# test_embedding = emb_text("This is a test")
# embedding_dim = len(test_embedding)
# print(embedding_dim)
# print(test_embedding[:10])

# model = Word2Vec(content, vector_size=10, window=5, min_count=1, workers=4, seed=36)
# model.save("custom_mopdel.model")

# print(res)

import time

# query_vectors = embedding_fn.encode_queries(["What is a JIT compiler?"])
query_vectors = embedding_fn.encode_queries(["Why do UNIX servers not regularly support tens of thousands of concurrent clients"])
# If you don't have the embedding function you can use a fake vector to finish the demo:
# query_vectors = [ [ random.uniform(-1, 1) for _ in range(768) ] ]
# print(query_vectors)
time.sleep(2)

res = client.search(
    collection_name="quick_setup",  # target collection
    data=query_vectors,  # query vectors
    limit=2,  # number of returned entities
    output_fields=["text", "subject"],  # specifies fields to be returned
)
# time.sleep(20)

print(res[0][0]['entity'])
