import { Router } from "express";
import { createNewLawyer, getAllLawyers, verifyLawyer } from "../controllers/lawyer.controller.js";
const router = Router();

router.post("/register",async (req,res)=>{
    const body = req.body;
    const lawyer = await createNewLawyer(body);
    res.send(lawyer); 
});

router.post("/login", async (req,res)=>{
    const body = req.body;
    const lawyer = await verifyLawyer(body);
    res.send(lawyer); 
});

router.get("/list",async (req,res) => {
    const lawyers = await getAllLawyers();
    res.send(lawyers);
})
export default router;