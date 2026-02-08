import bcrypt from "bcrypt";
import { createUser, findEmail } from "./auth.repository.js";
import { signRefreshToken, signAccessToken } from "./jwt.js";

export const loginService = async ({
  email,
  password,
}: {
  email: string;
  password: string;
}) => {
  const user = await findEmail(email);

  if (!user) {
    throw new Error("User not found");
  }

  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) {
    throw new Error("Invalid password");
  }

  const accessToken = signAccessToken({ id: user.id });
  const refreshToken = signRefreshToken({ id: user.id });

  return { user, accessToken, refreshToken };
};

export const registerService = async ({
  email,
  username,
  password,
  dob,
}: {
  email: string;
  username: string;
  password: string;
  dob: string;
}) => {
  const existingUser = await findEmail(email);
  if (existingUser) {
    throw new Error("Email already in use");
  }
  const hash = await bcrypt.hash(password, 10);
  const user = await createUser({ email, username, password: hash, dob });
  return {user};
};
