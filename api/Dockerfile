FROM python:3.9.6

#makes and cds into the app directory
WORKDIR /app

#copies requirements to the app directory
COPY requirements.txt /app/requirements.txt

#only runs when the requirements txt changes
RUN pip install -r requirements.txt

#copies everything else in the API folder
COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]