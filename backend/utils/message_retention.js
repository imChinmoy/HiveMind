import { messages } from "../src/database/schema";
import { db } from "../src/database/db";
import { sql } from "drizzle-orm";

export const messageRetention = async (req, res) => {
    try {
        
        await db.delete(messages).where(
            sql`created_at < NOW() - INTERVAL '3 day'`
        )

        res.status(200).json({message: "Message retention completed."});


    } catch (error) {
        res.status(500).json({message: "Internal server error."});
    }
}