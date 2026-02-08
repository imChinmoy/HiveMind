import { db } from "../../core/db/drizzle.js";
import { eq } from "drizzle-orm";
import { users } from "../../core/db/schema/userSchema.js";

export const findEmail = async (email: string) => {
  const res = await db.select().from(users).where(eq(users.email, email));
  return res[0];
};

export const createUser = async (payload: {
  email: string;
  username: string;
  password: string;
  dob: string;
}) => {
  await db.insert(users).values({
    email: payload.email,
    username: payload.username,
    password: payload.password,
    dob: new Date(payload.dob),
  });
};
