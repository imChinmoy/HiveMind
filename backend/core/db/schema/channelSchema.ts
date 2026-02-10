import { pgTable, timestamp, uuid, varchar } from "drizzle-orm/pg-core"
import { servers } from "./serverSchema.js"

export const channels = pgTable("channels", {
    id: uuid('id').defaultRandom().primaryKey(),
    name: varchar('name', { length: 50 }).notNull(),
    serverId: uuid('server_id').notNull().references(() => servers.id),
    description: varchar('description', { length: 255 }),
    createdAt: timestamp('created_at').defaultNow()
})