import streamlit as st
import requests
import json

# Ollama API endpoint
OLLAMA_API_URL = "http://localhost:11434/api/generate"

# Initialize session state to store conversation history
if 'conversation_history' not in st.session_state:
    st.session_state.conversation_history = []

def generate_response(prompt, model):
    # Prepare the request payload
    payload = {
        "model": model,
        "prompt": prompt,
        "context": st.session_state.get('context', []),
        "stream": False,
        # "keep_alive": -1
        "options":{
            "num_thread": 4,
            "num_ctx": 8096,
            }
    }

    # Send POST request to Ollama API
    response = requests.post(OLLAMA_API_URL, headers={"Content-Type": "application/json"}, json=payload)
    st.text_input("Your message:", value=response.content)
    
    if response.status_code == 200:
        result = response.json()
        generated_text = result.get('response', '')
        
        # Update the context for the next request
        st.session_state.context = result.get('context', [])
        
        return generated_text
    else:
        return f"Error: {response.status_code} - {response.text}"

# Streamlit app
st.title("Ollama Chat Interface")

# Model selection
model = st.selectbox("Select a model", ["llama31-7b-16k:latest", "llama3.1:70b", "vicuna"])

# User input
user_input = st.text_area("Your message:", height=100)

if st.button("Send"):
    if user_input:
        # Add user message to conversation history
        st.session_state.conversation_history.append(("You", user_input))
        
        # Generate response
        response = generate_response(user_input, model)
        
        # Add model response to conversation history
        st.session_state.conversation_history.append((f"{model.capitalize()} AI", response))

        # Clear the input field
        st.text_area("Your message:", value="", key="clear_input")

# Display conversation history
st.subheader("Conversation:")
for role, message in st.session_state.conversation_history:
    st.write(f"**{role}:** {message}")

# Option to clear conversation history
if st.button("Clear Conversation"):
    st.session_state.conversation_history = []
    st.session_state.context = []
    st.experimental_rerun()