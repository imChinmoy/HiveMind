import { Pool } from "pg";
import { config } from "../config/index.js";
import { logger } from "../logger/logger.js"

export const pool = new Pool({
  connectionString: config.DATABASE_URL,
  ssl: config.NODE_ENV === "production"
});


export async function connectPostgres() {
  try {
    const client = await pool.connect();
    client.release();
    logger.info("PostgreSQL connected");
  } catch (err) {
    logger.error("PostgreSQL connection failed");
    process.exit(1);
  }
}
