# Legal Help Backend

This repository contains a simple Express.js backend that provides several APIs
focused on Indian legal assistance.

## 🚀 Features

- 🧠 AI utilities for prompt optimization and prediction
- 💬 Chat endpoint that constructs a response using an external AI API
- 📄 Judgment scraper that pulls case details from Indian Kanoon
- 🔧 Example `.rest` files for manual testing using the VS Code REST Client

## 🛠 Installation

```bash
# clone repository
cd "c:/Users/Admin/Desktop/Legal Help/Backend"
npm install
```

## ⚙️ Environment

Create a `.env` file in the project root if you need to override defaults. The
backend reads the following variables:

- `PORT` – port for the server (defaults to `3000`)
- `AI_API_URL` – base URL of the external AI service used by chat and AI
  controllers (required for proper operation)
- `GEMINI_API_KEY` – (optional) API key used in the stubbed Gemini helper

## 📁 Project structure

```
app.js                 # express configuration and routes
server.js              # http server launcher
controllers/           # route handlers
helpers/               # shared logic (date helpers, chat context, etc.)
routes/                # express routers for each feature
response/              # REST client request templates
```

## 📡 API Endpoints

> Base API prefix:
>
> - `/ai` for AI utilities
> - `/chat` for chatbot history and generation
> - `/judgment` for case search and details
> - `/user` for end user auth
> - `/lawyer` for lawyer auth and data

### 1. User Auth

- `POST /user/register`
  - Body (JSON):
    ```json
    {
      "fullName": "string",
      "emailId": "string",
      "password": "string",
      "mobileNumber": "string",
      "dateOfBirth": "dd-mm-yyyy",
      "gender": "string",
      "profession": "string",
      "field": "string"
    }
    ```
  - Response:
    - Success: created user object
    - Error: `{ "error": "..." }` or `{ "error": "User already exist" }`

- `POST /user/login`
  - Body (JSON):
    ```json
    {
      "emailId": "string",
      "password": "string"
    }
    ```
  - Response:
    - Success: user object
    - Invalid password: `{ "message": "Password is not match" }`
    - No user: `{ "message": "User is not exist" }`

### 2. Lawyer Auth & Data

- `POST /lawyer/register`
  - Body (JSON): similar to `/user/register`.
  - Response:
    - Success: created lawyer object
    - Existing lawyer: `{ "message": "lawyer is already exist" }`

- `POST /lawyer/login`
  - Body (JSON): same as user login.
  - Response:
    - Success: lawyer object
    - Invalid password: `{ "message": "Password is not match" }`
    - No lawyer: `{ "message": "lawyer is not exist" }`

- `GET /lawyer/list`
  - Response: array of lawyer records or `{ "error": "Error while fetching lawyers" }`

- `POST /lawyer/upload`
  - Form Data: `image` (file)
  - Response: `{ "image": "<uploaded-file-path>" }`

### 3. Chatbot

- `POST /chat/generate?userId=<string>`
  - Body (JSON):
    ```json
    {
      "chatId": "string|null",
      "question": "string",
      "style": "string",
      "type": "string" // visual or text
    }
    ```
  - Behavior:
    - Builds prompt via `chatbot.helper.queryBuilder`
    - Sends request to `AI_API_URL` with random seed
    - Stores or updates chat history in DB via service layer
  - Response: saved chat object or error object

- `GET /chat/get_chat_list?userId=<string>`
  - Response: list of chatbot entries for user

- `DELETE /chat/delete?chatId=<string>`
  - Response: deletion result object

### 4. AI utilities

- `GET /ai/optimize_prompt?prompt=<text>`
  - Response: raw optimized text from AI API

- `GET /ai/predict_prompts?prompt=<text>`
  - Response: raw predicted prompts text (JSON string expected)

- `GET /ai/enhance_intro?intro=<text>`
  - Response: raw enhanced intro text

### 5. Judgment scraping

- `GET /judgment/get_by_court?court_name=<court>&from_date=<d-m-Y>&to_date=<d-m-Y>&options=<sort>&search=<term>&page_idx=<number>`
  - Query details:
    - `court_name`: single value (e.g. `supremecourt`, `highcourts`, `all_courts`)
    - `from_date`, `to_date`: defaults to recent range from helper
    - `options`: sort setting, default `mostrecent`
    - `search`: case text filter
    - `page_idx`: paging index starting at 0
  - Response:
    ```json
    {
      "totalDoc": <number>,
      "judgements": [ ... ]
    }
    ```

- `GET /judgment/get_detailed_judgment?url=<full-indiankanoon-url>`
  - Response: text content of scraped judgment body

## 🧪 Testing

Use the `.rest` files under `response/` to send requests with the VS Code REST
client plugin. This is the quickest way to experiment with the APIs.

```
response/ai/optimize_prompt.rest
response/ai/predict_prompts.rest
response/chatbot/generate.rest
response/judgment/get_by_court.rest
```

## 📦 Dependencies

- Node.js (tested with 18+)
- express
- node-fetch (built-in or via polyfill for versions <18)
- cheerio for HTML scraping

Install with `npm install` (see `package.json` for full list).

## 💡 Tips

- If you extend the API (e.g. add `user`/`lawyer` routes), add corresponding
  REST files in `response/` for consistency.
- Keep `AI_API_URL` pointed at a reliable LLM or summarization service.
- The scraping logic in `judgment.controller.js` assumes the IndianKanoon
  layout – update selectors if they change.

---

Happy coding! 😊
