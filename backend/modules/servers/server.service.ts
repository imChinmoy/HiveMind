import { addMemberToServer, createServer, findServer, ownerServers } from "./server.repository.js";
import { db } from "../../core/db/drizzle.js";
import { servers, serverMembers } from "../../core/db/schema/serverSchema.js";

export const listUserServersService = async (userId: string) => {
  return ownerServers(userId);
};

export const createServerService = async ({
  name,
  avatar,
  userId,
}: {
  name: string;
  avatar?: string;
  userId: string;
  role?: string;
}) => {
  const isExist = await findServer({ name });

  if (isExist) {
    throw new Error("Server with this name already exists");
  }
  return createServer({ name, avatar, userId});
};

export const joinServerService = async ({
  name,
  userId,
}: {
  name: string;
  userId: string;
}) => {
  const server = await findServer({ name });

  if (!server) {
    throw new Error("Server not found");
  }

  const result = await addMemberToServer({ serverId: server.id, userId });
  return result;
};
