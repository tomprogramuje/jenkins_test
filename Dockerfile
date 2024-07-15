# Dockerfile for building custom Python 3.12 on Alpine Linux image
FROM python:3.12-alpine

# Install any additional packages you need
#RUN apk add --no-cache bash curl

# Set up your working directory
WORKDIR /app

# Copy your application code into the container
COPY . /app

# Install Python dependencies (if applicable)
# Example: RUN pip install -r requirements.txt

# Set the default command to be run when the container starts
CMD ["python", "--version"]
