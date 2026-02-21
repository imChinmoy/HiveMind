import { serverMembers, servers } from "../../core/db/schema/serverSchema.js";
import { db } from "../../core/db/drizzle.js";
import { and, eq, or } from "drizzle-orm";

export const createServer = async ({
  name,
  avatar,
  userId,
  description
}: {
  name: string;
  avatar?: string;
  userId: string;
  description?:string;
}) => {
  const server = await db
    .insert(servers)
    .values({
      name,
      avatar,
      owner: userId,
      description
    })
    .returning();

  await db.insert(serverMembers).values({
    serverId: server[0].id,
    userId,
    role: "owner",
  });
  return server[0];
};

export const ownerServers = async (userId: string) => {
  const userServers = await db
    .select({
      id: servers.id,
      name: servers.name,
      avatar: servers.avatar,
      owner: servers.owner,
      createdAt: servers.createdAt,
      joinedAt: serverMembers.joinedAt,
      role: serverMembers.role
    })
    .from(serverMembers)
    .innerJoin(servers, eq(serverMembers.serverId, servers.id))
    .where(eq(serverMembers.userId, userId));

  return userServers;
};

export const findServer = async ({ name }: { name: string }) => {
  const server = await db.select().from(servers).where(eq(servers.name, name));
  return server[0];
};

export const addMemberToServer = async ({
  serverId,
  userId,
}: {
  serverId: string;
  userId: string;
}) => {
  const isExist = await db
    .select()
    .from(serverMembers)
    .where(
      and(
        eq(serverMembers.serverId, serverId),
        eq(serverMembers.userId, userId),
      ),
    );

  if (isExist.length > 0) {
    throw new Error("User is already a member of this server");
  }

  const [result] = await db.insert(serverMembers).values({
    serverId,
    userId,
  }).returning();
  return result;
};

export const leaveServer = async ({
  serverId,
  userId,
}: {
  serverId: string;
  userId: string;
}) => {
  const isMember = await db
    .select()
    .from(serverMembers)
    .where(
      and(
        eq(serverMembers.serverId, serverId),
        eq(serverMembers.userId, userId),
      ),
    );

  if (isMember.length === 0) {
    throw new Error("User is not a member of this server");
  }

  await db
    .delete(serverMembers)
    .where(
      and(
        eq(serverMembers.serverId, serverId),
        eq(serverMembers.userId, userId),
      ),
    );

  await db.select().from(servers).where(eq(servers.id, serverId));
};
