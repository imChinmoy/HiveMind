import { pgTable, uuid, varchar, text, integer, timestamp, boolean, uniqueIndex, index } from "drizzle-orm/pg-core";


export const users = pgTable(
  "users",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    username: varchar("username", { length: 50 }).notNull(),
    email: varchar("email", { length: 255 }).notNull(),
    password: text("password").notNull(),

    age: integer("age"),

    firebaseUid: varchar("firebase_uid", { length: 128 }).unique(),

    avatarUrl: text("avatar_url"),

    isOnline: boolean("is_online").default(false),

    createdAt: timestamp("created_at").defaultNow(),
    updatedAt: timestamp("updated_at").defaultNow(),
  },
  (table) => ({
    emailIdx: uniqueIndex("users_email_idx").on(table.email),
    usernameIdx: uniqueIndex("users_username_idx").on(table.username),
  })
);


export const servers = pgTable(
  "servers",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    name: varchar("name", { length: 100 }).notNull(),
    iconUrl: text("icon_url"),

    ownerId: uuid("owner_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),

    createdAt: timestamp("created_at").defaultNow(),
  }
);


export const serverMembers = pgTable(
  "server_members",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    serverId: uuid("server_id")
      .notNull()
      .references(() => servers.id, { onDelete: "cascade" }),

    userId: uuid("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),

    role: varchar("role", { length: 20 }).default("member"),

    joinedAt: timestamp("joined_at").defaultNow(),
  },
  (table) => ({
    uniqueMember: uniqueIndex("server_user_unique").on(
      table.serverId,
      table.userId
    ),
  })
);


export const channels = pgTable(
  "channels",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    name: varchar("name", { length: 100 }).notNull(),

    serverId: uuid("server_id")
      .notNull()
      .references(() => servers.id, { onDelete: "cascade" }),

    isPrivate: boolean("is_private").default(false),

    createdAt: timestamp("created_at").defaultNow(),
  },
  (table) => ({
    serverIdx: index("channels_server_idx").on(table.serverId),
  })
);



export const messages = pgTable(
  "messages",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    channelId: uuid("channel_id")
      .notNull()
      .references(() => channels.id, { onDelete: "cascade" }),

    senderId: uuid("sender_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),

    content: text("content").notNull(),

    createdAt: timestamp("created_at").defaultNow(),
  },
  (table) => ({
    channelIdx: index("messages_channel_idx").on(table.channelId),
  })
);


export const invites = pgTable(
  "invites",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    code: varchar("code", { length: 10 }).notNull(),

    serverId: uuid("server_id")
      .notNull()
      .references(() => servers.id, { onDelete: "cascade" }),

    createdBy: uuid("created_by")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),

    expiresAt: timestamp("expires_at"),

    createdAt: timestamp("created_at").defaultNow(),
  },
  (table) => ({
    inviteCodeIdx: uniqueIndex("invite_code_idx").on(table.code),
  })
);
