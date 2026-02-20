bash
#!/bin/bash

echo "================================="
echo "Starting LushBot Services"
echo "================================="
echo

echo "[1/3] Starting Qdrant..."
docker start qdrant 2>/dev/null || docker run -d -p 6333:6333 -v qdrant_data:/qdrant/storage --name qdrant qdrant/qdrant >/dev/null 2>&1
echo "Done!"

echo "[2/3] Starting Ollama..."
ollama serve &
echo "Done!"

echo "[3/3] Starting Flask server..."
sleep 3
cd backend
source ../.venv/bin/activate
python app.py &
echo "Done!"

echo
echo "================================="
echo "LushBot Started!"
echo "================================="
echo

echo "🌐 Frontend (Chatbot): http://localhost:5000"
echo "🔐 Admin Login: http://localhost:5000/login.html"
echo "📊 Chat Logs: http://localhost:5000/logs.html"
echo "Opening browser in 5 seconds..."
sleep 5
xdg-open http://localhost:5000