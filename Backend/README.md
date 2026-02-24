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

All endpoints are `GET` requests. Example queries are provided in the
`response/` folder – open those `.rest` files in VS Code and run them to test.

### 1. AI services

- `/ai/optimize_prompt?prompt=<text>`
  - Returns a refined version of your prompt for Indian law queries.

- `/ai/predict_prompts?prompt=<text>`
  - Returns a JSON object with 5 predicted prompt continuations.

### 2. Chat

- `/chat/generate?question=<text>&style=<index>&type=<index>&isGemini=<bool>`
  - Builds a combined prompt using `chatbot_style.js` values, optionally
    forwards to Gemini (currently commented out), and returns model output.

### 3. Judgments

- `/judgment/get_by_court?court_name=<court>&from_date=<d-m-Y>&to_date=<d-m-Y>&options=<sort>&search=<term>`
  - Scrapes IndianKanoon and returns a list of judgement metadata.
  - `court_name` may be `all_courts` or the specific court identifier.
  - `from_date`/`to_date` default to the last two months; `options` defaults
    to `mostrecent`.

> **Note:** the scraper loops over 5 pages and pulls results from the HTML.

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
