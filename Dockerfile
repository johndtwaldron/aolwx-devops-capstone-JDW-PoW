FROM python:3.9-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN python -m pip install --upgrade pip wheel \
 && pip install --no-cache-dir -r requirements.txt
COPY service ./service
RUN useradd -m theia && chown -R theia:theia /app
USER theia
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
