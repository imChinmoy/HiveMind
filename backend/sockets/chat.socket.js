import jwt from "jsonwebtoken";
import { db } from "../src/database/db.js";
import { messages, channels, serverMembers } from "../src/database/schema.js";
import { eq } from "drizzle-orm";

export const chatSocket = (io) => {
    io.use((socket, next) => {
        try {
            const token = socket.handshake.auth?.token;
            const decoded = jwt.verify(token, process.env.JWT_SECRET);
            socket.user = decoded;
            next();
        } catch {
            next(new Error("Unauthorized"));
        }
    });

    io.on("connection", (socket) => {
        console.log("User connected:", socket.user.username);
        socket.on("join_channel", ({ channelId }) => {
            socket.join(channelId);
            console.log("User joined channel:", channelId);
        });

        socket.on("send_message", async ({ channelId, content }) => {
            
            if (!content?.trim()) return;

            const [channel] = await db
                .select()
                .from(channels)
                .where(eq(channels.id, channelId));

            if (!channel) return;

            const member = await db
                .select()
                .from(serverMembers)
                .where(
                    eq(serverMembers.serverId, channel.serverId),
                    eq(serverMembers.userId, socket.user.userId)
                );

            if (member.length === 0) return;

            const [message] = await db
                .insert(messages)
                .values({
                    channelId,
                    senderId: socket.user.userId,
                    senderName: socket.user,
                    content,
                })
                .returning();


            io.to(channelId).emit("receive_message", message);
        });
    });
};
