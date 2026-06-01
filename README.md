# Telegram Operator Platform

Минимальная веб-платформа для ответа клиентам, которые пишут Telegram-боту.

## Архитектура

- Backend: Python + FastAPI
- Frontend: React + TypeScript + Vite
- Database: SQLite через SQLModel
- Telegram: long-polling
- Обновление интерфейса: polling фронтенда раз в 3 секунды

## Структура проекта

```text
backend/
frontend/
```

## Запуск backend

Создай файл `backend/.env`:

```env
TELEGRAM_BOT_TOKEN=сюда_токен_бота
OPERATOR_LOGIN=operator
OPERATOR_PASSWORD=operator
AUTH_TOKEN=dev-token
```

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Проверка:

Открой в браузере http://127.0.0.1:8000/health

Ожидаемый ответ:

```json
{"status":"ok"}
```

При старте backend автоматически создаёт SQLite-базу `backend/operator_platform.db`.
В ней будут таблицы `chat` и `message`.

Основные backend API:

- `POST /login`
- `GET /chats`
- `GET /chats/{id}/messages`
- `POST /chats/{id}/messages`

## Запуск frontend

```bash
cd frontend
npm install
npm run dev
```

Открой в браузере http://127.0.0.1:5173

## Секреты

Токен Telegram-бота, логин и пароль оператора должны храниться в `.env`.
Файл `.env` не должен попадать в git.
