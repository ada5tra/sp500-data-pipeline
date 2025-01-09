# Step 1: Use an official Python image as the base image
FROM python:3.9-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the Python script and dataset into the container
COPY script.py /app/
COPY constituents-financials.csv /app/

# Step 4: Install the necessary dependencies (without --no-cache-dir)
RUN pip install pandas plotly

# Step 5: Run the Python script
CMD ["python", "script.py"]
