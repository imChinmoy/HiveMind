import { Router } from "express";
import { authMiddleware } from "../../../middlewares/auth.middleware.js";
import { createChannelController, listAllChannelsController } from "../../../modules/channels/channel.controller.js";

const router = Router();

router.get("/", authMiddleware, listAllChannelsController);
router.post("/create", authMiddleware, createChannelController);

export default router;