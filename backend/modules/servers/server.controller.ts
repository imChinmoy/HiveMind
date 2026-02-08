import { Request, Response } from "express";
import {
  createServerService,
  joinServerService,
  listUserServersService,
} from "./server.service.js";
import { createServerSchema } from "./server.schema.js";
export async function createServerController(req: Request, res: Response) {
  try {
    const { name, avatar } = req.body;
    const userId = req.user.id;

    if (!name) {
      throw new Error("Server name is required");
    }
    const safeData = createServerSchema.parse({ name, avatar, userId });

    const server = await createServerService(safeData);

    res.json(server);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}

export async function listServersController(req: Request, res: Response) {
  try {
    const userId = req.user.id;

    const servers = await listUserServersService(userId);

    res.json(servers);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}

export async function joinServerController(req: Request, res: Response) {
  try {
    const { serverName } = req.body;
    const userId = req.user.id;

    if (!serverName) {
      throw new Error("Server name is required");
    }

    const server = await joinServerService({ name: serverName, userId });
    res.json(server);
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}