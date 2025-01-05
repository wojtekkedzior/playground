#!/bin/bash

curl http://localhost:11434/api/generate -d '{"model": "tinyllama"}'


curl -vvv http://localhost:11434/api/generate -d '
{  
"model": "tinyllama",  
"prompt": "Why is the blue sky blue?",  
"stream": false,
"options":{
  "num_thread": 8,
  "num_ctx": 2024
  }
}' | jq .response


curl -vvv http://192.168.1.115:8081/api/generate -d '
{  
"model": "tinyllama",  
"prompt": "Why is the blue sky blue?",  
"stream": false,
"options":{
  "num_thread": 8,
  "num_ctx": 2024
  }
}' | jq .response


curl -vvv http://192.168.1.115:8081/api/tags | jq -r ".models[].name"