import {Router} from "express";
import { createNewUser, verifyUser } from "../controllers/user.controller.js";

const router = Router();

router.post("/register", async (req,res)=>{
    const userData = req.body;
    console.log(userData);
    
    const data = await createNewUser(userData);
    res.send(data);
});

router.post("/login", async (req,res)=>{
    const userData = req.body;
    console.log(userData);
    
    const data = await verifyUser(userData);
    res.send(data);
});

export default router;