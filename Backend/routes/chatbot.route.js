import { Router } from "express";
import {
  deleteChat,
  generateResponse,
  getChatsList,
} from "../controllers/chatbot.controller.js";

const router = Router();

router.post("/generate", async (req, res) => {
  const userId = req.query.userId;
  const query = req.body;
  console.log(query);

  const output = await generateResponse(query, userId);
  console.log("call");

  res.send(output);
});

router.get("/get_chat_list", async (req, res) => {
  const userId = req.query.userId;
  const output = await getChatsList(userId);
  res.send(output);
});

router.delete("/delete", async (req, res) => {
  const chatId = req.query.chatId;
  const output = await deleteChat(chatId);
  res.send(output);
});

export default router;
