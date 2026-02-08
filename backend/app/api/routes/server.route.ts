import { Router } from "express";
import { authMiddleware } from "../../../middlewares/auth.middleware.js";
import { createServerController, joinServerController, leaveServerController, listServersController } from "../../../modules/servers/server.controller.js";


const router = Router();

router.post("/create", authMiddleware, createServerController);
router.get("/myservers", authMiddleware, listServersController);
router.post("/join/", authMiddleware, joinServerController);
router.post("/leave/:serverId", authMiddleware, leaveServerController);

export default router;


