import { drizzle } from "drizzle-orm/node-postgres";
import { pool } from "./postgres.js";

export const db = drizzle(pool);
