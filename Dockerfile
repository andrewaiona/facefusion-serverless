# Use the official RunPod base image with Python 3.10 and CUDA 11.8 (Standard for AI)
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

# Set up the working directory inside the container
WORKDIR /app

# Install system tools needed for video processing (FFmpeg is critical for FaceFusion)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy your requirements file first (to cache dependencies)
COPY requirements.txt .

# Install your Python libraries
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your code
COPY . .

# This is the command RunPod runs when the server starts
CMD [ "python", "-u", "handler.py" ]
