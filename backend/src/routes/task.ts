import { Router } from "express";
import { auth, type AuthRequest } from "../middleware/auth.js";
import { tasks, type NewTask } from "../db/schema.js";
import { db } from "../db/index.js";
import { eq } from "drizzle-orm";

const taskRouter = Router();

taskRouter.post("/", auth, async(req: AuthRequest, res) => {
    try {
        req.body = {...req.body, uid: req.user };
        const newTask: NewTask = req.body;
        const [task] = await db.insert(tasks).values(newTask).returning(); 

        res.status(201).json(task);
    } catch (e) {
        res.status(500).json({error : e});
    }
});
taskRouter.get("/", auth, async(req: AuthRequest, res) => {
    try {
        const allTasks = await db.select().from(tasks).where(eq(tasks.uid, req.user!));

        res.status(201).json(allTasks);
    } catch (e) {
        res.status(500).json({error : e});
    }
});

export default taskRouter;