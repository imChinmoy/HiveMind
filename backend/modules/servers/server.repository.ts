import { serverMembers, servers } from "../../core/db/schema/serverSchema.js";
import { db } from "../../core/db/drizzle.js";
import { and, eq } from "drizzle-orm";

export const createServer = async ({
  name,
  avatar,
  userId,
}: {
  name: string;
  avatar?: string;
  userId: string;
}) => {
  const server = await db.insert(servers).values({
    name,
    avatar,
    owner:userId,
  }).returning();

  await db.insert(serverMembers).values({
    serverId: server[0].id,
    userId,
    role: 'owner'
  });
  return server[0];
};

export const ownerServers = async (userId: string) => {

    const userServers = await db.select().from(servers).where(eq(servers.owner, userId));
    return userServers;

}

export const findServer = async ({name
}:{
    name: string;
}) => {
    const server = await db.select().from(servers).where(eq(servers.name, name));
    return server[0];
} 

export const addMemberToServer = async ({
  serverId,
  userId,
}:{
  serverId: string;
  userId: string;
}) => {

  const existingMember = await db.select().from(serverMembers).where(and(
    eq(serverMembers.serverId, serverId),
    eq(serverMembers.userId, userId),
    eq(serverMembers.role, 'owner')
  ));

  if (existingMember.length > 0) {
    throw new Error("User is already a member of this server");
  }

  const result = await db.insert(serverMembers).values({
    serverId,
    userId,
  });
  return result;
}