import jwt from "jsonwebtoken";

const ACCESS_SECRET = process.env.ACCESS_SECRET!;
const REFRESH_SECRET = process.env.REFRESH_SECRET!;

export const verifyToken = (token: string) => {
  return jwt.verify(token, ACCESS_SECRET);
};

export const signAccessToken = (payload: object) => {
  return jwt.sign(payload, ACCESS_SECRET, { expiresIn: "1d" });
};

export const signRefreshToken = ( payload: object) => {
    return jwt.sign(payload, REFRESH_SECRET, { expiresIn: "7d" });
}