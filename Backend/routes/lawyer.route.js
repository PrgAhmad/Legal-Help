import { Router } from "express";
import {
  createNewLawyer,
  getAllLawyers,
  uploadLawyerPic,
  verifyLawyer,
} from "../controllers/lawyer.controller.js";
import { upload } from "../config/multer.js";
const router = Router();

router.post("/register", async (req, res) => {
  const body = req.body;
  const lawyer = await createNewLawyer(body);
  res.send(lawyer);
});

router.post("/login", async (req, res) => {
  const body = req.body;
  const lawyer = await verifyLawyer(body);
  res.send(lawyer);
});

router.get("/list", async (req, res) => {
  const lawyers = await getAllLawyers();
  res.send(lawyers);
});

router.post("/upload", upload.single("image"), async (req, res) => {
  console.log(req.file.path);
  
  const imagePic = await uploadLawyerPic(req.file.path);
  console.log(imagePic);
  
  res.send(imagePic);
});
export default router;
