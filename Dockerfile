FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app
COPY . /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       wget \
       libnss3 \
       libatk-bridge2.0-0 \
       libatk1.0-0 \
       libatspi2.0-0 \
       libcups2 \
       libdrm2 \
       libgbm1 \
       libgtk-3-0 \
       libnspr4 \
       libxcomposite1 \
       libxdamage1 \
       libxfixes3 \
       libxkbcommon0 \
       libxrandr2 \
       libasound2 \
       fonts-liberation \
    && python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt \
    && python -m playwright install chromium \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /app/railway_start.sh

EXPOSE 8000
CMD ["/app/railway_start.sh"]
