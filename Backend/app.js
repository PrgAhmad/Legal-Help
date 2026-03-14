import { configDotenv } from "dotenv";
configDotenv();

import { connectToDB } from "./config/database.js";
connectToDB();

import express from "express";
const app = express();

import chat from "./routes/chatbot.route.js";
import ai from "./routes/ai.route.js";
import judgment from "./routes/judgment.route.js";
import user from "./routes/user.route.js";
import lawyer from "./routes/lawyer.route.js";

app.use(express.json());

app.use("/ai", ai);
app.use("/chat", chat);
app.use("/judgment", judgment);
app.use("/user", user);
app.use("/lawyer", lawyer);

app.get("/", (req, res) => {
  res.json({ message: "welcome to legal help backend" });
});

export default app;
