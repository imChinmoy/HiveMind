import { Router } from "express";
import { authMiddleware } from "../../../middlewares/auth.middleware.js";
import { createServerController, joinServerController, leaveServerController, listServersController, listTopServersController } from "../../../modules/servers/server.controller.js";


const router = Router();

router.post("/create", authMiddleware, createServerController);
router.get("/myservers", authMiddleware, listServersController);
router.get("/topservers", authMiddleware, listTopServersController);
router.post("/join/", authMiddleware, joinServerController);
router.delete("/leave/:serverId", authMiddleware, leaveServerController);

export default router;


