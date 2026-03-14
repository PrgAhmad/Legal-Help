import { Router } from "express";
import {
  enchanceIntro,
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

router.get("/enhance_intro", async (req, res) => {
  const intro = req.query.intro;
  const enchanceIntros = await enchanceIntro(intro);
  res.send(enchanceIntros);
});


export default router;
