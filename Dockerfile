# Use a stable version of Python as the parent image.
FROM python:3.8.18-slim-bullseye

# Set environment variables for Python to run in a more efficient manner.
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Set the working directory in the container.
WORKDIR /app

# Copy the requirements.txt file to leverage Docker cache.
COPY requirements.txt /app/

# Install Python dependencies.
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install -r requirements.txt

# Copy the source code into the container.
COPY . /app/

# Copy entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the port that the application listens on.
EXPOSE 8000

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Use Django's built-in server to run the application.
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
