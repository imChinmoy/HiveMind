import { eq, desc } from "drizzle-orm";
import { messages } from "../../core/db/schema/messageSchema.js";
import { db } from "../../core/db/drizzle.js";

export async function createMessage(data: {
  channelId: string;
  authorId: string;
  content: string;
}) {
  const result = await db.insert(messages).values(data).returning();

  return result[0];
}

export async function getMessages(channelId: string, limit = 50) {
  return db
    .select()
    .from(messages)
    .where(eq(messages.channelId, channelId))
    .orderBy(desc(messages.createdAt))
    .limit(limit);
}


export async function deleteMessage(messageId: string) {
  return db
    .update(messages)
    .set({
      deletedAt: new Date(),
    })
    .where(eq(messages.id, messageId))
    .returning();
}
