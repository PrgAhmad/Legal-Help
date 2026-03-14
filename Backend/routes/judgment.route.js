import { Router } from "express";
import { getDetailedJudgment, getJudgments } from "../controllers/judgment.controller.js";

const router = Router();

router.get("/get_by_court", async (req, res) => {
  const { court_name, from_date, to_date, options, search, page_idx } = req.query;
  const judgments = await getJudgments({
    courtName: court_name,
    fromDate: from_date,
    toDate: to_date,
    options,
    search,
    pageIdx: page_idx
  });
  res.json(judgments);
});

router.get("/get_detailed_judgment", async (req, res) => {
  const { url } = req.query;
  const judgment = await getDetailedJudgment({
    url,
  });
  res.json(judgment);
});

export default router;
