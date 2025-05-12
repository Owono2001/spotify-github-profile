# Use an official Python runtime as a parent image
FROM python:3.11-bullseye

# Set environment variables to prevent Python from writing .pyc files to disc and to keep output unbuffered
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements file from your project's api directory into the /app directory in the container
COPY ./api/requirements.txt /app/requirements.txt

# Install any needed packages specified in requirements.txt
# Using --no-cache-dir to reduce image size
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application's code from the current directory (.) on your host
# to the /app directory in the container. This includes your 'api' folder, 'util' folder, etc.
COPY . /app/

# Command to run your application using sh -c to ensure $PORT expansion
CMD ["sh", "-c", "gunicorn --chdir api view:app -w 4 -b 0.0.0.0:$PORT"]
