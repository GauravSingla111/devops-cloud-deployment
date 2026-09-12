from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)


@app.route("/")
def home():
    return f"""
    <html>
        <head>
            <title>DevOps Cloud Deployment Demo</title>
        </head>
        <body>
            <h1>DevOps Cloud Deployment Demo - version 2</h1>
            <p>Status: Running - version 2</p>
            <p>Environment: {os.getenv("ENVIRONMENT", "development")}</p>
            <p>Hostname: {socket.gethostname()}</p>
        </body>
    </html>
    """


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": "devops-demo"
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)