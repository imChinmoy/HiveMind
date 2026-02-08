import { Request, Response } from "express";
import {
  createServerService,
  listUserServersService,
} from "./server.service.js";

export async function createServerController(req: Request, res: Response) {
  try {
    const { name, avatar } = req.body;
    const userId = req.user.userId;

    const server = await createServerService({ name, avatar, userId });

    res.json(server);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}

export async function listServersController(req: Request, res: Response) {
  try {
    const userId = req.user.userId;

    const servers = await listUserServersService(userId);

    res.json(servers);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}
