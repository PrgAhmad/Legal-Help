import { Router } from "express";
import { getJudgment } from "../controllers/judgment.controller.js";

const router = Router();

router.get("/get_by_court", async (req, res) => {
  const { court_name, from_date, to_date, options, search, page_idx } = req.query;
  const judgments = await getJudgment({
    courtName: court_name,
    fromDate: from_date,
    toDate: to_date,
    options,
    search,
    pageIdx: page_idx
  });
  res.json(judgments);
});

export default router;
