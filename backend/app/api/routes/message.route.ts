import { Router } from "express";
import { authMiddleware } from "../../../middlewares/auth.middleware.js";
import {
  sendMessageController,
  fetchMessagesController,
  deleteMessageController,
} from "../../../modules/message/message.controller.js";

const router = Router();

router.post("/", authMiddleware, sendMessageController);
router.get("/:channelId", authMiddleware, fetchMessagesController);
router.delete("/", authMiddleware, deleteMessageController);

export default router;
