FROM node:22-slim AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM python:3.12-slim
WORKDIR /app

COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt

COPY backend/ ./backend/
COPY --from=frontend-build /app/frontend/dist ./backend/frontend_dist

WORKDIR /app/backend
ENV HOST=0.0.0.0
ENV PORT=8000
ENV DATABASE_URL=sqlite:////data/operator_platform.db
ENV UPLOAD_DIR=/data/uploads

CMD ["sh", "-c", "uvicorn app.main:app --host ${HOST} --port ${PORT}"]
