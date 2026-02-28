import { eq, desc, and, lt, isNull } from "drizzle-orm";
import { messages } from "../../core/db/schema/messageSchema.js";
import { db } from "../../core/db/drizzle.js";
import { users } from "../../core/db/schema/userSchema.js";

export async function createMessage(data: {
  channelId: string;
  authorId: string;
  content: string;
}) {
  const result = await db.insert(messages).values(data).returning();
  
  // Return with author info
  const messageWithAuthor = await db
    .select({
      id: messages.id,
      channelId: messages.channelId,
      authorId: messages.authorId,
      content: messages.content,
      createdAt: messages.createdAt,
      deletedAt: messages.deletedAt,
      authorName: users.username,
    })
    .from(messages)
    .leftJoin(users, eq(messages.authorId, users.id))
    .where(eq(messages.id, result[0].id))
    .limit(1);

  return messageWithAuthor[0];
}

export async function getMessages(channelId: string, limit = 50, before?: string) {
  const conditions = [
    eq(messages.channelId, channelId),
    isNull(messages.deletedAt),
  ];

  if (before) {
    conditions.push(lt(messages.createdAt, new Date(before)));
  }

  return db
    .select({
      id: messages.id,
      channelId: messages.channelId,
      authorId: messages.authorId,
      content: messages.content,
      createdAt: messages.createdAt,
      deletedAt: messages.deletedAt,
      authorName: users.username,
    })
    .from(messages)
    .leftJoin(users, eq(messages.authorId, users.id))
    .where(and(...conditions))
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
