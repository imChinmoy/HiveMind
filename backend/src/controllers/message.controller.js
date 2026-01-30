import { db } from "../database/db.js";
import { messages, channels, serverMembers } from "../database/schema.js";
import { eq, lt, desc } from "drizzle-orm";

export const getChannelMessages = async (req, res) => {
    try {
        const { channelId } = req.params;
        const { cursor, limit = 30 } = req.query;
        const userId = req.user.userId;

        const [channel] = await db
            .select()
            .from(channels)
            .where(eq(channels.id, channelId));

        if (!channel) {
            return res.status(404).json({ message: "Channel not found." });
        }

        const member = await db
            .select()
            .from(serverMembers)
            .where(
                eq(serverMembers.serverId, channel.serverId),
                eq(serverMembers.userId, userId)
            );

        if (member.length === 0) {
            return res.status(403).json({ message: "Not a member." });
        }

        const query = db
            .select()
            .from(messages)
            .where(eq(messages.channelId, channelId))
            .orderBy(desc(messages.createdAt))
            .limit(Number(limit));

        if (cursor) {
            query.where(lt(messages.createdAt, new Date(cursor)));
        }

        const result = await query;

        return res.status(200).json({
            messages: result.reverse(),
            nextCursor:
                result.length > 0 ? result[0].createdAt : null,
        });
    } catch (error) {
        console.error("Fetch messages error:", error);
        return res.status(500).json({ message: "Internal server error." });
    }
};
