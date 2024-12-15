FROM python:3.8-slim-buster

# Set the working directory
WORKDIR /app

# Copy only files needed for installing dependencies first
COPY requirements.txt /app/

# Install system dependencies, Python dependencies, and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        awscli \
        ffmpeg \
        libsm6 \
        libxext6 \
        unzip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy the application code
COPY . /app/

# Command to run the application
CMD ["python3", "app.py"]