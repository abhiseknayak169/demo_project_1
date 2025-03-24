# Use the official Python 3.11 image as the base image
FROM public.ecr.aws/docker/library/python:3.11

# Set environment variables
# PYTHONWRITEBYTECODE=1 prevents Python from writing .pyc files to disk
# PYTHONUNBUFFERED=1 ensures that Python output is sent straight to the terminal (unbuffered)
ENV PYTHONWRITEBYTECODE=1 \
    PYTHONUNBUFFEERED=1

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the requirements.txt file from the host machine to the /app directory in the container
COPY requirements.txt /app/

# Install Python dependencies
# Upgrade pip, setuptools, and wheel to the latest versions
# Then install the dependencies listed in requirements.txt
RUN pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

# Copy the entire project directory from the host machine to the /app directory in the container
COPY . /app/

# Copy the pre-trained model file to the /app/model directory in the container
COPY model/iris_model.joblib /app/model/iris_model.joblib

# Expose port 8002 to allow external access to the application running inside the container
EXPOSE 8002

# Define the command to run the application
# Use uvicorn to start the FastAPI application defined in main.py
# Bind the server to all network interfaces (0.0.0.0) and run it on port 8002
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8002"]