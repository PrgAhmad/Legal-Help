import { Router } from "express";
import {
  optimizePrompt,
  predictPrompts,
} from "../controllers/ai.controller.js";
const router = Router();

router.get("/optimize_prompt", async (req, res) => {
  const prompt = req.query.prompt;
  const optimizedPrompt = await optimizePrompt(prompt);
  res.send(optimizedPrompt);
});

router.get("/predict_prompts", async (req, res) => {
  const prompt = req.query.prompt;
  const predictedPrompts = await predictPrompts(prompt);
  res.send(predictedPrompts);
});


export default router;
