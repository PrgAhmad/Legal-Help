import { Router } from "express";
import { getJudgment } from "../controllers/judgment.controller.js";

const router = Router();

router.get("/all_courts", async (req, res) => {
  const { courtName, year, options, search } = req.query;
  const judgments = await getJudgment({
    courtName,
    year,
    options,
    search,
  });
  res.json(judgments);
});

router.get("/single_court", async (req, res) => {
  const { courtName, year, options, search } = req.query;
  const judgments = await getJudgment({
    courtName,
    year,
    options,
    search,
  });
  res.json(judgments);
});

export default router;
