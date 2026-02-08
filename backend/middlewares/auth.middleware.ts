import { verifyToken } from "../modules/auth/jwt.js";
import { Request, Response, NextFunction } from "express";

declare global {
  namespace Express {
    interface Request {
      user?: any;
    }
  }
}

export function authMiddleware(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const header = req.headers.authorization;
  if (!header) {
    return res.status(401).json({ error: "Unauthorized" });
  }

  const [type, token] = header.split(" ");

  if (type !== "Bearer" || !token) {
    return res.status(401).json({ error: "Unauthorized" });
  }

  try {
    const payload = verifyToken(token);
    req.user = payload;
    next();
  } catch (error: any) {
    return res.status(401).json({ error: "Invalid token: " + error.message });
  }
}
