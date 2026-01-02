import { configDotenv } from "dotenv";
configDotenv();

import express from "express";
const app = express();

import chat from "./routes/chat.route.js";


app.use(express.json());

app.use("/chat",chat);

export default app;