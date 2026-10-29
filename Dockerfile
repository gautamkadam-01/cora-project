FROM python:3.11-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

COPY requirements.txt .
RUN python -m pip install --no-cache-dir --retries 10 --timeout 120 --index-url https://pypi.org/simple -r requirements.txt

COPY main.py .
COPY static ./static
COPY data ./data
COPY simple_gcn_cora.onnx .
COPY simple_gcn_cora.onnx.data .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
