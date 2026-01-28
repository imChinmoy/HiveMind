import { servers, serverMembers, channels, invites } from "../database/schema.js"
import { db } from '../database/db.js'
import crypto from 'crypto';
import { eq, and } from "drizzle-orm";

export const createServer = async (req, res) => {
    try {
        const { name, icon_url } = req.body;
        const userId = req.user.userId;

        if (!name || !icon_url) {
            return res.status(400).json({ message: 'All fields are required.' });
        }

        const [server] = await db.insert(servers).values({
            name: name,
            iconUrl: icon_url,
            ownerId: userId
        }).returning();

        await db.insert(serverMembers).values({
            serverId: server.id,
            userId: userId,
            role: 'owner'
        })

        await db.insert(channels).values({
            name: 'general',
            serverId: server.id
        })

        const inviteCode = crypto.randomBytes(4).toString('hex');

        await db.insert(invites).values({
            code: inviteCode,
            serverId: server.id,
            createdBy: userId
        })

        res.status(201).json({
            messages: 'Server created successfully.',
            server: {
                id: server.id,
                name: server.name,
                iconUrl: server.iconUrl,
                inviteCode
            }
        });


    } catch (error) {
        res.status(500).json({ message: `Error creating server: ${error.message}` });
    }
}

export const joinServer = async (req, res) => {

    try {
        const { inviteCode } = req.body;
        const userId = req.user.userId;

        if (!inviteCode) {
            return res.status(400).json({ message: 'Invite code is required.' });
        }

        const [invite] = await db.select().from(invites).where(eq(invites.code, inviteCode));

        if (!invite) {
            return res.status(404).json({ message: 'Server code not found.' });
        }

        const alreadyJoined = await db.select().from(serverMembers).where(and(eq(serverMembers.serverId, invite.serverId), eq(serverMembers.userId, userId)));

        if (alreadyJoined.length > 0) {
            return res.status(400).json({ message: 'You are already a member of this server.' });
        }

        await db.insert(serverMembers).values({
            serverId: invite.serverId,
            userId: userId,
            role: 'member'
        })

        res.status(201).json({
            messages: 'Server joined successfully.',
            server: {
                id: invite.id,
                name: invite.name,
                iconUrl: invite.iconUrl
            }
        });


    } catch (error) {
        res.status(500).json({ message: `Error joining server: ${error.message}` });
    }
}

export const getServers = async (req, res) => {
    try {
        const userId = req.user.userId;

        const myServers = await db
            .select({
                id: servers.id,
                name: servers.name,
                iconUrl: servers.iconUrl,
                role: serverMembers.role,
            })
            .from(serverMembers)
            .innerJoin(servers, eq(serverMembers.serverId, servers.id))
            .where(eq(serverMembers.userId, userId));

        return res.status(200).json(myServers);
    } catch (error) {
        console.error("Get servers error:", error);
        return res.status(500).json({ message: "Internal server error." });
    }
};


export const leaveServer = async (req, res) => {
    try {
        const { serverId } = req.params;
        const userId = req.user.userId;

        const [server] = await db
            .select()
            .from(servers)
            .where(eq(servers.id, serverId));

        if (!server) {
            return res.status(404).json({ message: "Server not found." });
        }

        if (server.ownerId === userId) {
            return res
                .status(400)
                .json({ message: "Owner cannot leave the server." });
        }

        await db
            .delete(serverMembers)
            .where(
                eq(serverMembers.serverId, serverId),
                eq(serverMembers.userId, userId)
            );

        return res.status(200).json({ message: "Left server successfully." });
    } catch (error) {
        console.error("Leave server error:", error);
        return res.status(500).json({ message: "Internal server error." });
    }
};

