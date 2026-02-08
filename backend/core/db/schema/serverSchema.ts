import { pgTable, timestamp, uuid, varchar } from "drizzle-orm/pg-core";

export const servers = pgTable("servers", {
    id: uuid('id').defaultRandom().primaryKey(),
    name: varchar('name', { length: 50 }).notNull(),
    avatar: varchar('avatar', { length: 255 }),
    owner: uuid('owner_id').notNull(),
    createdAt: timestamp('created_at').defaultNow()
})

export const serverMembers = pgTable('server_members', {
    serverId: uuid('server_id').notNull(),
    userId: uuid('user_id').notNull(),
    joinedAt: timestamp('joined_at').defaultNow(),
    role: varchar('role', { length: 20 }).default('member')
})