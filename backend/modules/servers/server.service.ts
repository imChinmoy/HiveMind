import {
  addMemberToServer,
  createServer,
  findServer,
  leaveServer,
  ownerServers,
  topServers
} from "./server.repository.js";

export const listUserServersService = async (userId: string) => {
  return ownerServers(userId);
};

export const listTopServersService = async (
  userId: string,
  limit: number,
  offset: number
) => {
  return topServers(userId, limit, offset);
};

export const createServerService = async ({
  name,
  avatar,
  userId,
  description
}: {
  name: string;
  avatar?: string;
  userId: string;
  role?: string;
  description?: string
}) => {
  const isExist = await findServer({ name });

  if (isExist) {
    throw new Error("Server with this name already exists");
  }
  return createServer({ name, avatar, userId, description });
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

export const leaveServerService = async (serverId: string, userId: string) => {
  const result = await leaveServer({ serverId, userId });
  return result;
};
