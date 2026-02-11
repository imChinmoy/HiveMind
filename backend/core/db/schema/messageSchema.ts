import { pgTable, timestamp, uuid, varchar } from "drizzle-orm/pg-core"
import { channels } from "./channelSchema.js"

export const messages = pgTable("messages", {
    id: uuid('id').defaultRandom().primaryKey(),
    channelId: uuid('channel_id').notNull().references(() => channels.id),
    authorId: uuid('author_id').notNull(),
    content: varchar('content', { length: 2000 }).notNull(),
    createdAt: timestamp('created_at').defaultNow(),
    deletedAt: timestamp('deleted_at')
})