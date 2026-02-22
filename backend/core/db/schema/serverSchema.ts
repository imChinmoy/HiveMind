import { pgTable, primaryKey, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { users } from "./userSchema.js";

export const servers = pgTable("servers", {
  id: uuid("id").defaultRandom().primaryKey(),
  name: varchar("name", { length: 50 }).notNull(),
  avatar: varchar("avatar", { length: 255 }),
  description: varchar("description", { length: 255 }),
  owner: uuid("owner_id")
    .notNull()
    .references(() => users.id),
  createdAt: timestamp("created_at").defaultNow(),
});

export const serverMembers = pgTable(
  "server_members",
  {
    serverId: uuid("server_id")
      .notNull()
      .references(() => servers.id),
    userId: uuid("user_id")
      .notNull()
      .references(() => users.id),
    joinedAt: timestamp("joined_at").defaultNow(),
    role: varchar("role", { length: 20 }).default("member"),
  },
  (table) => ({
    pk: primaryKey(table.serverId, table.userId),
  }),
);
