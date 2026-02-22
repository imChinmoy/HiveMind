import { Request, Response } from "express";
import {
  createServerService,
  joinServerService,
  leaveServerService,
  listUserServersService,
  listTopServersService,
} from "./server.service.js";
import { createServerSchema } from "./server.schema.js";
export async function createServerController(req: Request, res: Response) {
  try {
    const { name, avatar, description } = req.body;
    const userId = req.user.id;

    if (!name) {
      throw new Error("Server name is required");
    }
    const safeData = createServerSchema.parse({
      name,
      avatar,
      userId,
      description,
    });

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

export async function listTopServersController(req: Request, res: Response) {
  try {
    const userId = req.user.id;
    const { limit, offset } = req.query;

    if (limit === undefined || offset === undefined) {
      return res.status(400).json({ message: "Limit and offset are required" });
    }

    const parsedLimit = Number(limit);
    const parsedOffset = Number(offset);

    if (isNaN(parsedLimit) || isNaN(parsedOffset) || parsedLimit <= 0) {
      return res.status(400).json({ message: "Invalid limit or offset" });
    }

    const servers = await listTopServersService(userId, parsedLimit, parsedOffset);
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

export async function leaveServerController(req: Request, res: Response) {
  try {
    const { serverId } = req.params;
    const userId = req.user.id;

    if (!serverId) {
      throw new Error("Server ID is required");
    }

    await leaveServerService(serverId.toString(), userId);
    res.json({ message: "Left the server successfully" });
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}
