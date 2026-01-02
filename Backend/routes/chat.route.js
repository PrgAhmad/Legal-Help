import { Router } from "express";
import { generateResponse } from "../controllers/chat.controller.js";

const router = Router();

router.get("/generate", async (req, res) => {
  const query = req.query;

  const output = await generateResponse(query);
  res.send(output);
});

export default router;
