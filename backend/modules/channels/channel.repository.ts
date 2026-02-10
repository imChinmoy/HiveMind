import { eq, and } from "drizzle-orm";
import { db } from "../../core/db/drizzle.js";
import { findServer } from "../servers/server.repository.js";
import { channels } from "../../core/db/schema/channelSchema.js";

export const findAllChannels = async ({
  serverId,
  serverName,
}: {
  serverId: string;
  serverName: string;
}) => {
  const server = await findServer({ name: serverName });
  if (!server) {
    throw new Error("Server not found!!!");
  }

  const result = await db
    .select()
    .from(channels)
    .where(eq(channels.serverId, serverId));

  return result;
};

export const createChannel = async ({
  name,
  serverId,
  description,
}: {
  name: string;
  serverId: string;
  description?: string;
}) => {
  const isExisting = await db
    .select()
    .from(channels)
    .where(and(eq(channels.name, name), eq(channels.serverId, serverId)));

  if (isExisting.length > 0) {
    throw new Error("Channel with this name already exists!!!");
  }

  await db.insert(channels).values({
    name,
    serverId,
    description,
  });
  const result = await db
    .select()
    .from(channels)
    .where(and(eq(channels.name, name), eq(channels.serverId, serverId)))
    .limit(1);
  return result[0];
};
