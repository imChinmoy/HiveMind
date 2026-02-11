import { Request, Response } from "express";
import {
  sendMessageService,
  fetchMessagesService,
  deleteMessageService,
} from "./message.service.js";
import { createMessageSchema } from "./message.schema.js";

export async function sendMessageController(req: Request, res: Response) {
  try {
    const parsed = createMessageSchema.parse(req.body);

    const authorId = req.user.id;

    const message = await sendMessageService(
      parsed.channelId,
      authorId,
      parsed.content,
    );

    res.json(message);
  } catch (error) {
    res.status(400).json({
      error: error instanceof Error ? error.message : "Unknown error",
    });
  }
}

export async function fetchMessagesController(req: Request, res: Response) {
  try {
    const { channelId } = req.params;

    const messages = await fetchMessagesService(channelId.toString());

    res.json(messages);
  } catch (error) {
    res.status(400).json({
      error: error instanceof Error ? error.message : "Unknown error",
    });
  }
}

export async function deleteMessageController(req: Request, res: Response) {
  try {
    const { messageId } = req.body;

    const deleted = await deleteMessageService(messageId);

    res.json(deleted);
  } catch (error) {
    res.status(400).json({
      error: error instanceof Error ? error.message : "Unknown error",
    });
  }
}
