import { servers, serverMembers, channels, invites } from "../database/schema.js"
import { db } from '../database/db.js'
import crypto from 'crypto';

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