import { servers } from "../../core/db/schema/serverSchema.js";
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

