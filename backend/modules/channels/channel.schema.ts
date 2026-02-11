import { z } from "zod";

export const createChannelSchema = z.object({
    name: z.string().min(1).max(50),
    serverId: z.string().uuid(),
    description: z.string().max(255).optional()
})

export const getAllChannelsSchema = z.object({
    serverId: z.string().uuid(),
    serverName: z.string().min(1).max(50)
})