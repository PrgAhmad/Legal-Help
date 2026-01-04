import { configDotenv } from "dotenv";
configDotenv();

import express from "express";
const app = express();

import chat from "./routes/chat.route.js";
import ai from "./routes/ai.route.js";

app.use(express.json());

app.use("/ai", ai);
app.use("/chat", chat);

app.get("/", (req, res) => {
  res.json({ message: "welcome to legal help backend" });
});

export default app;
