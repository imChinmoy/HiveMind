import { Request, Response } from "express";
import {
  createChannelService,
  getAllChannelsService,
} from "./channel.service.js";
import { createChannelSchema, getAllChannelsSchema } from "./channel.schema.js";

export const listAllChannelsController = async (
  req: Request,
  res: Response,
) => {
  try {
    const { serverId, serverName } = req.query;

    if (!serverId) {
      throw new Error("Server ID is required!!!");
    }

    const safeData = getAllChannelsSchema.parse({ serverId, serverName });

    const result = await getAllChannelsService(safeData);
    res.status(200).json(result);
  } catch (error) {
    res.status(400).json({ error: (error as Error).message });
  }
};

export const createChannelController = async (req: Request, res: Response) => {
  try {
    const { name, serverId, description } = req.body;

    if (!name || !serverId) {
      throw new Error("Name and Server ID are required!!!");
    }
    const safeData = createChannelSchema.parse({ name, serverId, description });

    const result = await createChannelService(safeData);
    res.status(201).json(result);
  } catch (error) {
    res.status(400).json({ error: (error as Error).message });
  }
};
